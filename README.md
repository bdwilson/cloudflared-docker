# docker-cloudflared
<p>

A docker container for running [Cloudflare's Argo Tunnel](https://developers.cloudflare.com/argo-tunnel/quickstart/) to proxy a service.

This install is for tunneling multiple endpoints specified in a config.yml
file. To find a guide on this, please [see this
guide](https://omar2cloud.github.io/cloudflare/cloudflared/cloudflare/). 
 
For cloudflared to trust tunneling to Let's Encrypt endpoints, you need to pass
it the LE intermediate (or updated cacerts on your endpoint). I've updated
entrypoint.sh to do this.

* `./build.sh` will build your image.
 
For my usecase, I store containers in /var/docker/<container> and data files in
/var/docker/<container>/data.  You will need to update your dirs accordingly.
<b>Also, copy your le-chain.pem to your data dir</b>. 

* `docker run --rm -v /var/docker/cloudflared/data:/etc/cloudflared -v /var/docker/cloudflared/data:/root/.cloudflared cloudflared login`

You'll login using the URL presented and authorize one of your domains for use
with the tunnel. For a [guide on this](https://omar2cloud.github.io/cloudflare/cloudflared/cloudflare/).
Successful login will store your certs.pem in /var/docker/cloudflared/data

* `docker run --rm -v /var/docker/cloudflared/data:/etc/cloudflared -v /var/docker/cloudflared/data:/root/.cloudflared cloudflared create mytunnel`

This will create a tunnel called mytunnel and give you an ID.  Follow the above
docs on creating your config.yml and storing it in the data directory. Once
complete, run your tunnel.

* `docker run --rm -v /var/docker/cloudflared/data:/etc/cloudflared -v /var/docker/cloudflared/data:/root/.cloudflared cloudflared run`

Іf you want to run this as a docker container so that it starts on reboot, you
can do it this way. This will create a container called cloudflared. 

* `docker run -d --restart unless-stopped -v /var/docker/cloudflared/data:/etc/cloudflared --v /var/docker/cloudflared/data:/root/.cloudflared --name cloudflared cloudflared run`

Inspired by the [msnelling/docker-cloudflared](https://github.com/msnelling/docker-cloudflared) container.
