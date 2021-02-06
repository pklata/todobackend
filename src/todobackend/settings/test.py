from .base import *
import os

INSTALLED_APPS += ('django_nose',)
TEST_RUNNER = 'django_nose.NoseTestSuiteRunner'
TEST_OUTPUT_DIR = os.environ.get('TEST_OUTPUT_DIR', '.')
NOSE_ARGS = [
    '--verbosity=2',
    '--nologcapture',
    '--with-coverage',
    '--cover-package=todo',
    '--with-spec',
    '--spec-color',
    '--with-xunit',
    f'--xunit-file={TEST_OUTPUT_DIR}/unittests.xml',
    '--cover-xml',
    f'--cover-xml-file={TEST_OUTPUT_DIR}/coverage.xml'
]

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': os.environ.get('MYSQL_DATABASE', 'todobackend'),
        'USER': os.environ.get('MYSQL_USER', 'todo'),
        'PASSWORD': os.environ.get('MYSQL_PASSWORD', 'password'),
        'HOST': os.environ.get('MYSQL_HOST', 'localhost'),
        'PORT': os.environ.get('MYSQL_PORT', '3306'),
        'TEST': {
            'NAME': 'todobackend',
        },
    }
}

# docker run -d --name mysql1 -p 3306:3306 -e MYSQL_DATABASE=todobackend -e MYSQL_USER=todo -e MYSQL_PASSWORD=password -e MYSQL_RANDOM_ROOT_PASSWORD=1 mysql
