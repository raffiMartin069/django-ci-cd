from django.views.generic import TemplateView
from django.shortcuts import render, HttpResponse
from django.http import JsonResponse

# Create your views here.
def index(request):
    return render(request, "index.html", {})

def login_request(request):
    if request.method == "POST":
        # Use request.POST to extract form data
        username = request.POST.get("email")  # Safely get the 'email' field
        password = request.POST.get("password")  # Safely get the 'password' field

        # Example logic for a login process (implement actual validation)
        if username and password:  # Add actual authentication logic here
            response = {
                "message": "Logged In",
                "username": username,  # Optional: Include user info if needed
            }
            return JsonResponse(response)
        else:
            return JsonResponse({"message": "Invalid email or password"}, status=400)

    # Handle non-POST requests
    return JsonResponse({"message": "Only POST method is allowed"}, status=405)
