import pytest
from django_app.web import factories as web_factories
from pytest_factoryboy import register


# enable database for all tests
@pytest.fixture(autouse=True)
def enable_db(db):
    pass


register(web_factories.UserFactory)
