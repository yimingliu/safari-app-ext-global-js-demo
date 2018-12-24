function handleExtensionMessage(msg_event)
{
    console.log("Received message event", msg_event)
    if (window.top === window)
    {
        if (msg_event.name === "global-js-message")
        {
            var message = msg_event.message;
            alert(message.value);
        }
    }
    
}
document.addEventListener("DOMContentLoaded", function(event) {
    safari.extension.dispatchMessage("init-world");
    safari.self.addEventListener("message", handleExtensionMessage);
});
