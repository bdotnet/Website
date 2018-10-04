$(document).ready(function(){
    $("#speaker-submit").click(function(){
        var name = $("#speaker-name").val();
        var email = $("#speaker-email").val();
        var topic = $("#speaker-description").val();
        var ip = $("#speaker-ip").val();

        var jsonData = {name: name, email: email, topic: topic};
        var postData = JSON.stringify(jsonData);
       // alert(postData);
        
        $.ajax({
            url: "http://"+ip+"api/SubmitTalk?t=Talk proposal from :" + name +"&d=" + email + "/n" + topic,
            method: "post",
            data: postData,
            success: function(d)
            {
                alert("Thanks. We will get back to you.");
            }
        })
    });
});