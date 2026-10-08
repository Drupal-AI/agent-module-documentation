# Rules HTTP Client — manual setup guide

**Rules HTTP Client** (`rules_http_client`) adds an HTTP‑request **action** to the
[Rules](https://www.drupal.org/project/rules) module. Rules automates "when X
happens, do Y"; this module makes one of the possible Ys "make an HTTP request." So a
reaction rule can call an external URL as part of an automation — firing a webhook
when content is published, posting data to an API, notifying another system, and so
on. HTTP is the backbone of web communication, so this opens up a wide range of
integrations without custom code.

You add the action inside a rule and tell it what request to make (the URL, and
depending on the release, the method, headers, and body). When the rule runs, your
Drupal server sends that request.

**The security consideration to understand is server‑side request forgery (SSRF).**
The action makes the *server* issue a request. When the URL is a fixed value that an
administrator set, the risk is low — an admin building a rule can already reach out to
the network. The risk appears when the URL, or part of it, is drawn from
**user‑controlled data** (for example a submitted field fed into the action through a
Rules data selector): an attacker could steer the server to fetch internal services.
Treat any rule whose request URL comes from untrusted input as an SSRF surface —
prefer static or admin‑controlled URLs, validate or allow‑list the destination, and
restrict who is allowed to build Rules, since a rule author can make the server call
arbitrary URLs.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Rules dependency.
2. [Configuration](configuration/index.md) — add and configure the HTTP‑request
   action inside a rule, and harden it against SSRF.

## Where it lives in the admin menu

Rules HTTP Client has no settings page of its own. The action it provides is
configured inside individual rules at **Configuration → Workflow → Rules**
(`/admin/config/workflow/rules`). See [Configuration](configuration/index.md).
