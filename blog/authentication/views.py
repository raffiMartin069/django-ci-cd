from django.views.generic import TemplateView
from django.shortcuts import render

# Create your views here.
class Login(TemplateView):
    template_name = "login.html"

    def post(self, request):
        return render(request, "login.html", {"message": "You are logged in."})