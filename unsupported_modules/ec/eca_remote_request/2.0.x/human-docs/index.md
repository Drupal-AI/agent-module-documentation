# ECA Remote Requests — manual setup guide

**ECA Remote Requests** (`eca_remote_request`) lets your no‑code
[ECA](https://www.drupal.org/project/eca) models make **server‑side HTTP calls**
and react to the results — without writing any PHP. It ships three plugins: a
**Run Remote Requests** action that issues an outbound request (GET, POST, PUT,
PATCH, DELETE, HEAD or OPTIONS) to a URL and captures the response into an ECA
token; a **Convert JSON to List** action that parses a JSON string into an ECA
list you can loop over; and an **Is JSON Data** condition that tests whether a
value is valid JSON. Together these let a workflow call an external REST API or
webhook, branch on the response, and reuse the returned data in later steps.

Like other ECA integration modules, it has no settings form of its own — the
plugins appear inside the ECA model editor and you configure each request on the
model. The request body and Guzzle request options (headers, authentication,
proxy, timeouts, TLS verification) are supplied as ECA‑token‑replaced YAML, so
model authors have full control over how the request is made.

**A security note worth reading before you use it.** Because a model author can
set any Guzzle option and any URL, this action is a powerful outbound‑request
tool. It can be pointed at internal addresses (a server‑side request forgery, or
SSRF, concern) and it can disable TLS certificate verification if a model
explicitly sets `verify: false`. The action always reports "access allowed" —
the real gate is *who may edit and run ECA models*, which is an administrative
capability. Guzzle keeps TLS verification on by default; leave it on. Treat ECA
model authoring on this site as trusted. Note also that this project is currently
marked **unsupported/obsolete** on drupal.org, so weigh that before relying on it
in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside ECA.

There is **no configuration page** for this module. It adds plugins you use
inside ECA models; see "How to use it" below.

## Where it lives in the admin menu

ECA Remote Requests adds no admin page of its own. You use it from the **ECA**
model editor (**Administration → Configuration → Workflow → ECA**), where its
Run Remote Requests / Convert JSON to List actions and the Is JSON Data condition
become available when you build or edit a model.

## How to use it

1. Make sure ECA is installed and enabled.
2. Open the ECA model editor and create or edit a model.
3. Add an event to trigger the model, then add the **Run Remote Requests**
   action. Set the URL, method, and — for write methods — the request body and
   its type (`form_params` or `json`). Add any Guzzle options (such as an
   `Authorization` header) as YAML, and name the token that will receive the
   response (its status, headers and body).
4. Optionally add the **Is JSON Data** condition to gate the next steps, and the
   **Convert JSON to List** action to turn a JSON response into a list you can
   iterate.
5. Save and enable the model. Because the request URL and options live in
   configuration, export and review the model as you would review code — and keep
   TLS verification enabled.
