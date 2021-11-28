# docker-cloudflared
<p>

A docker container for running [Cloudflare's Argo Tunnel](https://developers.cloudflare.com/argo-tunnel/quickstart/) to proxy a service.

This install is for tunneling multiple endpoints for a single domain specified in a single config.yml
file. To find a more robust guide on doing this, please [see this
guide](https://omar2cloud.github.io/cloudflare/cloudflared/cloudflare/). 
 
* `./build.sh` will build your image.
 
For my usecase, I store containers in /var/docker/<i>container</i> and data files in
/var/docker/<i>container</i>/data. <b> You will need to update your dirs
 accordingly for all the commands below.</b>

* `docker run --rm -v /var/docker/cloudflared/data:/etc/cloudflared -v /var/docker/cloudflared/data:/root/.cloudflared cloudflared login`

You'll login using the URL presented and authorize one of your cloudflare domains for use
with the tunnel - if you wish to use multiple domains, you'll need to run multiple cloudflared containers as it appears the login mappings & config files are per-domain. For a [guide on this](https://omar2cloud.github.io/cloudflare/cloudflared/cloudflare/).
Successful login will store your certs.pem in /var/docker/cloudflared/data

* `docker run --rm -v /var/docker/cloudflared/data:/etc/cloudflared -v /var/docker/cloudflared/data:/root/.cloudflared cloudflared create mytunnel`

This will create a tunnel called <b>mytunnel</b> and give you an ID.  Follow the above
docs on creating your config.yml and <b>storing it in the data directory</b>. Once
complete, add your DNS routes and then run your tunnel (<b>mytunnel</b> in this
case; you'll need to change myapp.mydomain to match the name and domain (remember, only the one you authorized will work) you've
specified in your config.yml. A sample is provided for you. 

Note, if you're planning on tunneling [Unifi
Controller](https://github.com/bdwilson/unifi-letsencrypt-cloudflare) traffic,
you will need a legit certificate on it. I have linked my script that will help
you do this via Let's Encrypt. I've been unable to get cloudflared to accept a
self-signed certificate. 

* `docker run --rm -v /var/docker/cloudflared/data:/etc/cloudflared -v /var/docker/cloudflared/data:/root/.cloudflared cloudflared route dns mytunnel myapp.mydomain.com`

Now run your tunnel

* `docker run --rm -v /var/docker/cloudflared/data:/etc/cloudflared -v /var/docker/cloudflared/data:/root/.cloudflared cloudflared run`

Іf you want to run this as a docker container so that it starts on reboot, you
can do it this way. This will create a container called cloudflared. 

* `docker run -d --restart unless-stopped -v /var/docker/cloudflared/data:/etc/cloudflared -v /var/docker/cloudflared/data:/root/.cloudflared --name cloudflared cloudflared run`

Inspired by the [msnelling/docker-cloudflared](https://github.com/msnelling/docker-cloudflared) container.
