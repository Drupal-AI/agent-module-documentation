# Configuration

Setting up Page Not Found Passthrough has two parts: configuring the module's own
settings (fallback domains and 404 handling), and telling Drupal core to use the
module as its 404 page.

## 1. Configure the module settings

1. Log in as an administrator.
2. Go to **Configuration → Search and metadata → Page Not Found Passthrough
   (Redirect on 404)**.

On this form you set:

- **Legacy / fallback servers** — the domains to try, in order, when a page 404s on
  your site. When a visitor hits a missing path, the module requests that same path
  on each fallback host in turn and redirects to the first one that resolves. Enter
  only **trusted hosts** and prefer **HTTPS** — the requested path is forwarded to
  each host as a server‑side request.
- **Fallback 404 page** — a custom page or path to show if none of the fallback
  hosts have the content.
- **User message** — optional text shown to the visitor when nothing is found.
- **Site‑search fallback (optional)** — a search URL so that, when no fallback host
  can serve the path, the visitor is sent to your search results for that term (for
  example, `example.com/department` → `example.com/search/department`).

Save the form when you're done.

## 2. Point Drupal's default 404 page at the module

For the passthrough to run, Drupal core must hand its 404s to the module:

1. Go to **Configuration → System → Basic site settings**
   (`/admin/config/system/site-information`).
2. Set the **Default 404 (not found) page** to `/notfoundpassthrough`.
3. Save.

(This step may become unnecessary in a future version of the module.)

## Good to know

- **Fast 404 compatibility:** if you use the Fast 404 module, it runs first and
  handles those requests itself, so they never reach Page Not Found Passthrough.
- **Keep the fallback list trusted:** because the module makes server‑side requests
  to the configured hosts, only list domains you control or trust, and use HTTPS.
  The hosts are admin‑configured (not chosen by visitors), so this is not open SSRF,
  but a trusted, HTTPS‑only list is the safe way to run it.

## Verify

Request a path that doesn't exist on your Drupal site but does exist on a fallback
host — you should be redirected to the fallback. Then request a path that exists on
neither, and confirm you get your configured fallback 404 page, message, or search
redirect.
