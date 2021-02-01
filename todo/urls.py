from django.urls import path, include
from rest_framework.routers import DefaultRouter

from todo import views

router = DefaultRouter(trailing_slash=False)
router.register(r'todos', views.TodoItemViewSet)

urlpatterns = [
    path('', include(router.urls))
]