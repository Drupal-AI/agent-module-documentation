# HTTPS and WWW Redirect — manual setup guide

**HTTPS and WWW Redirect** (`httpswww`) makes sure your site is always reached
through one canonical address. It issues a 301 redirect whenever a visitor arrives
on the "wrong" version of your URL — the insecure `http://` when you want HTTPS, or
the `www.` host when you prefer the bare domain (or the other way round). That keeps
search engines from splitting your ranking across duplicate addresses and gives
visitors a single, consistent URL.

Everything is controlled from one small settings page. You can force all traffic to
**HTTPS**, and independently choose to **add** a `www.` prefix, **strip** it, or
leave the host alone. When you are adding `www.`, an exclusion list lets specific
subdomains (like `api` or `shop`) keep their bare host. A master on/off switch lets
you enable or disable the whole thing without losing your chosen settings.

The redirect runs very early in each request, before most of Drupal does its work,
so wasted processing on requests that will just be redirected is kept to a minimum.
The module is dependency-free and works on Drupal 8.7.7 through 11 — a lightweight
alternative to hand-writing `.htaccess` or web-server rewrite rules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, every option, and
   the two permissions (including the important "bypass" one).

## Where it lives in the admin menu

The settings form is at **Configuration → System → HTTPS and WWW Redirect**
(`/admin/config/system/httpswww`), gated by the *Administer HTTPS and WWW Redirects*
permission.

## Important: avoid locking yourself out

Because the redirect can change the host or scheme of your very next request, saving
a change while you are on a different host/scheme than the one you select can log you
out or redirect you away. Before experimenting, grant yourself the *Bypass HTTPS and
WWW Redirects* permission (see [Configuration](configuration/index.md)) so you are
never subject to the redirect while you test.
