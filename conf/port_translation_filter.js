var upstreammessagecount = 0;

function handler(s) {
    if (s.fromUpstream) { 
        upstreammessagecount++;
        //s.log("messagecount [" + upstreammessagecount + "]");
        if (upstreammessagecount <= 9 ) {
            s.buffer = s.buffer.replace(/\"Port\":37777/g, "\"Port\":80");
            s.buffer = s.buffer.replace(/^Port:37777/gm, "Port:80");
        }
    }
    return;
}
