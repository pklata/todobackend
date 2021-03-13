from setuptools import setup, find_packages

setup(
    name = "todobackend",
    version= "0.1.0",
    description = "Todobackend Django REST service",
    packages = find_packages(),
    include_package_data = True,
    scripts = ["manage.py"],
    install_requires = [
        "Django==3.1.7",
        "django-cors-headers==3.7.0",
        "djangorestframework==3.12.2",
        "mysql-connector==2.2.9",
        "PyMySQL==1.0.2"
    ],
    extras_require = {
        "test": [
            "colorama==0.4.4",
            "coverage==5.4",
            "django-nose==1.4.7",
            "nose==1.3.7",
            "pinocchio==0.4.2",
        ]
    }
)