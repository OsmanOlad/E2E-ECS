import pytest
from app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_health_check(client):
    """Test the /healthz endpoint."""
    rv = client.get('/healthz')
    assert rv.status_code == 200
    assert rv.get_json() == {"status": "ok"}

def test_shorten_missing_url(client):
    """Test /shorten fails without a URL."""
    rv = client.post('/shorten', json={})
    assert rv.status_code == 400
    assert "error" in rv.get_json()
