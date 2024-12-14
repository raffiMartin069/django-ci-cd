document.addEventListener('DOMContentLoaded', () => {
    
    const email = document.getElementById('email');
    const password = document.getElementById('password');

    function getCookie(name) {
        let cookieValue = null;
        if (document.cookie && document.cookie !== '') {
            const cookies = document.cookie.split(';');
            for (let i = 0; i < cookies.length; i++) {
                const cookie = cookies[i].trim();
                // Does this cookie string begin with the name we want?
                if (cookie.substring(0, name.length + 1) === (name + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }

    async function request(email, password, token) {
        try {
            const result = await fetch('/login/', {
                method: 'POST',
                headers: {
                    'X-CSRFToken': token,
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    email: email.value,
                    password: password.value,
                }),
            });

            const data = await result.json();

            if (!result.ok) {
                throw new Error(data.message);
            }

            alert(data.message);

        } catch (e) {
            console.error(e.message);
        }
    }

    document.getElementById('login').addEventListener('submit', (e) => {
        e.preventDefault();

        request(email, password, getCookie('csrftoken'));
    });
});