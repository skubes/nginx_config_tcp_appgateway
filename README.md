# nginx_config_tcp_appgateway
NGINX configuation for reverse proxy (TCP stream) of QC DVR app using nginScript and stream js module to filter responses.

The basic idea was for an NGINX reverse proxy to listen on port 80 (hosted in Microsoft Azure) and proxy incoming TCP requests to a Q-See QC Series Camera DVR. The DVR only accepts connections on user ports above 1024. By default the DVR is listening on port 37777 which may be blocked by firewalls.

The problem was not only that requests and responses needed to be proxied (which is a vanilla setup for NGINX), but the upstream-originating packets needed to be inspected and modified to do some port translation as the QC View app depends on the device responses for further connection info.

The "port translantion" is handled by the conf/port_translation_filter.js file and configured in the conf/nginx.conf file. TCP responses are acted on by a Javascript regex to change the port numbers in JSON or other responses.

Tested on NGINX 1.13.11 (buit using the --with-stream and --with-debug flags) for Red Hat Enterprise Linux 7.4.

The stream module was also built from source:
https://nginx.org/en/docs/stream/ngx_stream_js_module.html

It actually seemed to mostly work!

Though there are a few issues where trying to connect 16 simulaneous video streams some of them time-out but work if retried.  There are probably issues doing things this way -- one is I'm not sure if the way the packets are chunked is not allowing the js to work reliably. Perhaps there are too many hops to make this kind of proxying work with no other changes to the Q-See device or apps.)

Basically I got the idea from:
https://www.youtube.com/watch?v=QhUSSxvvwjE

