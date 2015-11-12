 $(function() {
    $('button').click(function() {
		alert('inside script');
        var user = $('#txtUsername').val();
        var pass = $('#txtPassword').val();
		alert(user);
        $.ajax({
            url: '/signUpUser',
            data: $('form').serialize(),
            type: 'POST',
            success: function(response) {
                console.log(response);
            },
            error: function(error) {
                console.log(error);
            }
        });
    });
});