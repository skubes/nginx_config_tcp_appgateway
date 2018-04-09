function handler(s) {
    if (s.fromUpstream) { 
            s.buffer = s.buffer.replace(/\"Port\":37777/g, "\"Port\":80");
            s.buffer = s.buffer.replace(/^Port:37777/gm, "Port:80");
    }
    return;
}
