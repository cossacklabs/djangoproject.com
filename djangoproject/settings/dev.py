from .common import *  # noqa

ALLOWED_HOSTS = [
    'www.djangoproject.test',
    'djangoproject.test',
    'docs.djangoproject.test',
    'dashboard.djangoproject.test',
] + SECRETS.get('allowed_hosts', [])

DEBUG = True
THUMBNAIL_DEBUG = DEBUG

CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.locmem.LocMemCache',
        'LOCATION': 'trololololol',
    },
}

CSRF_COOKIE_SECURE = False

EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'

MEDIA_ROOT = str(DATA_DIR.joinpath('media_root'))

SESSION_COOKIE_SECURE = False

STATIC_ROOT = str(DATA_DIR.joinpath('static_root'))

# Docs settings
DOCS_BUILD_ROOT = DATA_DIR.joinpath('djangodocs')

# django-hosts settings

PARENT_HOST = 'djangoproject.test:8000'

# django-push settings

PUSH_SSL_CALLBACK = False

# Enable optional components

if DEBUG:
    try:
        import debug_toolbar  # NOQA
    except ImportError:
        pass
    else:
        INSTALLED_APPS.append('debug_toolbar')
        INTERNAL_IPS = ['127.0.0.1']
        MIDDLEWARE.insert(
            MIDDLEWARE.index('django.middleware.common.CommonMiddleware') + 1,
            'debug_toolbar.middleware.DebugToolbarMiddleware'
        )
