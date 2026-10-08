# Freedom Commerce — manual setup guide

**Freedom Commerce** (project `freedom`, module machine name `freedom_commerce`)
removes Drupal Commerce's promotional **"Inbox"** messaging. If you've opened your
own Commerce site and been surprised to find a marketing inbox you never asked for —
with attention‑grabbing links, and your site quietly reaching out to the module
developer's server to download a message feed — this module puts a stop to it. Its
premise is simple: your Drupal site is yours, and you should be able to turn off
unwanted vendor messaging without editing `settings.php`.

Under the hood it does two clean things. It swaps Commerce's message‑fetcher service
for a **no‑op** version, so Commerce never pulls promotional messages from its remote
source (which also removes the outbound connection). And it hides the surfaces:
removing the inbox local action from admin menus, suppressing Commerce's toolbar
inbox indicator, and dropping the inbox panel from the Commerce dashboard. The rest
of Commerce is left completely untouched.

It's a deliberately tiny "freedom from marketing" utility. There is **nothing to
configure** — enabling it is the entire setup — and it adds no routes, forms, or
permissions of its own. To restore the default Commerce inbox behaviour, simply
uninstall it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (that's all there is to it).

This module has **no configuration** — there are no settings, routes, forms, or
permissions.

## Where it lives in the admin menu

Freedom Commerce adds no admin pages. Its effect is the *absence* of things: after
you enable it, the Commerce inbox local action, toolbar indicator, and dashboard
panel are gone, and Commerce stops fetching promotional messages.
