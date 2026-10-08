# Configuration

Security Kit is configured on a single page. Everything below happens at
**Configuration → System → Security Kit** (`/admin/config/system/seckit`),
which requires the **administer seckit** permission. The page groups related
headers into collapsible sections; click a section heading to expand it, tick
the checkbox that enables that protection, fill in the fields it reveals, and
click **Save configuration** at the bottom when you are done.

Every protection is **off by default**. Turn on only the headers you understand
and have tested — a mis-configured header can break page rendering or lock
visitors out of your site. This is especially true of Content Security Policy,
so start there and read the warning below carefully.

![The Security Kit settings page and its sections](../images/settings.png)

## Cross-site Scripting

Expand the **Cross-site Scripting** section. It configures two headers that
reduce the impact of XSS attacks.

### Content Security Policy

Content Security Policy (CSP) is the most powerful — and the most delicate —
protection SecKit offers. A CSP tells the browser exactly which sources it is
allowed to load scripts, styles, images, fonts, and other resources from.
Anything not on the list is blocked, which neutralises most injected inline
scripts and reduces XSS to a non-event. The trade-off is that an overly strict
policy will also block your own legitimate scripts and styles, so you must
tune it to your site.

1. Click **Content Security Policy** to expand it.
2. Tick the checkbox to enable CSP.
3. **Turn on report-only mode first.** Enable the report-only option so SecKit
   sends a `Content-Security-Policy-Report-Only` header instead of an enforcing
   one. In this mode the browser does not block anything — it only *reports*
   what *would* have been blocked. This lets you discover every resource your
   site legitimately loads before you risk breaking it.
4. Fill in the per-directive source fields for the resources your site uses.
   Each directive controls one class of resource:
   - **default-src** — the fallback source list for any directive you do not
     set explicitly.
   - **script-src** — where JavaScript may load from. Restricting this (and
     disallowing inline scripts) is what stops most XSS.
   - **style-src** — where CSS may load from.
   - **img-src** — where images may load from.
   - **font-src**, **media-src**, **connect-src** — fonts, audio/video, and
     AJAX/WebSocket/fetch endpoints, respectively.
   - **object-src**, **frame-src**, **child-src** — plugins/embeds and framed
     documents.
   - **frame-ancestors** — which sites may frame *your* pages (a clickjacking
     defence that complements X-Frame-Options).
   A common starting point is `'self'`, which permits resources from your own
   origin only, then adding the specific third-party hosts you actually use.
5. Optionally set a **report URI** — the address violation reports are POSTed
   to. SecKit ships a built-in reporting endpoint at `/report-csp-violation`
   that logs each violation, and this is the default. Because browsers must be
   able to reach it without authenticating, that endpoint is intentionally
   left open.
6. Optionally enable **upgrade-insecure-requests** to have the browser
   automatically rewrite `http://` sub-resource requests to `https://`, which
   helps eliminate mixed-content warnings.
7. Watch your reports (or your browser's developer console) until no legitimate
   resource is being flagged. Only then turn **off** report-only mode and save
   again to switch CSP into enforcing mode.

> **Test before you enforce.** Never enable an enforcing CSP on a live site
> without first running it in report-only mode long enough to catch every
> legitimate resource. An untested policy silently blocks your own scripts,
> styles, and images.

### X-XSS-Protection header

Below CSP, the **X-XSS-Protection header** controls a *legacy* browser filter.
Older browsers used this header to switch on a built-in reflected-XSS filter.
Modern browsers have removed the feature in favour of CSP, so this header is
useful only for compatibility with old clients. Pick the mode you want from the
select list, or leave it disabled if you only care about current browsers.

## Cross-site Request Forgery

Expand the **Cross-site Request Forgery** section to enable an Origin /
HTTP-referrer based CSRF check. When turned on, SecKit inspects the `Origin`
(and referrer) of incoming requests and rejects those that do not come from an
approved origin, adding a layer of protection against cross-site request
forgery. Add every origin your site is legitimately served from — and any
trusted external origin that posts to it — to the **allowlist**, otherwise
legitimate requests can be rejected.

## Clickjacking

Expand the **Clickjacking** section. Clickjacking (also called UI-redressing)
tricks users into clicking something on your site while it is hidden inside an
attacker's page via an invisible frame. SecKit offers two defences.

### X-Frame-Options header

The **X-Frame-Options header** tells browsers whether your pages may be
displayed inside a frame or iframe. Choose a value:

- **SAMEORIGIN** — only pages on your own domain may frame your site. This is
  the usual, safe choice.
- **DENY** — no site, including your own, may frame your pages.
- **ALLOW-FROM** — permit a single named origin to frame your pages (you supply
  that origin in the accompanying field).
- **Disabled** — send no header.

### JavaScript-based protection

The **JavaScript-based protection** option adds a fallback anti-framing
technique using JavaScript, CSS, and a `<noscript>` message. It is designed for
older browsers that do not honour X-Frame-Options. You can customise the
message shown to visitors who have JavaScript disabled. Use it in addition to
X-Frame-Options, not instead of it.

## SSL/TLS

Expand the **SSL/TLS** section to configure **HTTP Strict Transport Security
(HSTS)**. HSTS tells browsers to only ever connect to your site over HTTPS,
even if a user types `http://` or clicks an insecure link. This defends against
SSL-stripping attacks, where an attacker downgrades a connection to plain HTTP.

1. Enable HSTS.
2. Set the **max-age** — how long (in seconds) the browser should remember to
   force HTTPS. Start with a small value while testing, then raise it once you
   are confident HTTPS works everywhere.
3. Optionally apply HSTS to **all subdomains**, so the rule covers
   `www.`, `blog.`, and every other subdomain.
4. Optionally opt into the browser **preload** list, which bakes your domain
   into browsers so HTTPS is enforced even on a visitor's very first request.

> Only enable HSTS once your site is fully served over a valid HTTPS
> certificate. If HTTPS later breaks, browsers that have cached the policy will
> refuse to connect over HTTP, effectively taking your site offline for them
> until the max-age expires.

## Expect-CT

Expand the **Expect-CT** section to send the `Expect-CT` header, which asks
browsers to enforce **Certificate Transparency** — verifying that your TLS
certificate has been publicly logged. You can set a max-age, provide a report
URI for violations, and choose whether to run in enforcing mode. This is an
advanced, niche control; leave it off unless you specifically need it.

## Feature policy

Expand the **Feature policy** section to send a **Feature-Policy /
Permissions-Policy** header. This lets you allow or disallow individual browser
features — such as the camera, microphone, or geolocation — for your pages and
any content they embed. Enter the policy string that describes which features
are permitted and from which origins.

## Save your changes

When you have configured the sections you need, click **Save configuration** at
the bottom of the page. The headers take effect immediately on the next
response. Because all of these settings live in the `seckit.settings`
configuration object, you can export them with `drush config:export` and deploy
the exact same security-header policy across every environment.
