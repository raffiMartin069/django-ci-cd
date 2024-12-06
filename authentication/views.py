from django.views.generic import TemplateView
from django.shortcuts import render, HttpResponse

# Create your views here.
def index(request):
    return render(request, "index.html", {})