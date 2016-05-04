DATABASE_URL = 'postgresql:///var/lib/postgresql/socket.md:{{ project_name }}'
MEDIA_ROOT = '{{ root_dir }}/media'
STATIC_ROOT = '{{ root_dir }}/static'
MEDIA_URL = 'http://{{ domain }}/media/'
STATIC_URL = 'http://{{ domain }}/static/'
ALLOWED_HOSTS = ('{{ domain }}',)
