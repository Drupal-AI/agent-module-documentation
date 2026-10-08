<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Post Remote Queue posts webform submissions to a remote endpoint via a queue.

---

Webform Post Remote Queue **queues Webform submissions and POSTs them to a remote endpoint** — instead of
sending submission data to an external URL synchronously, it enqueues it and delivers via a queue worker (with
retries), for reliable remote delivery. It depends on the Webform module, in the Webform package.

Use it to reliably forward submissions to an external system. It is a forms/integration feature. Security/data
handling: submissions (which typically contain **PII**) are **sent to a configured remote endpoint** (external
egress) — point it only at a **trusted endpoint over HTTPS**, store any auth token/secret for that endpoint
securely (env/Key), and disclose the data flow per your privacy policy. It has no access-control role. Configure
the remote endpoint and queue.

---

- Queue and POST webform submissions.
- Deliver to a remote endpoint.
- Retry via a queue worker.
- Depend on the Webform module.
- Serve forms/integration.
- Forward submissions reliably.
- Send submission PII to a remote endpoint (egress).
- Point it at a trusted HTTPS endpoint.
- Store the endpoint's auth secret securely.
- Disclose the data flow per privacy policy.
- Have no access-control role.
- Configure the endpoint and queue.
- Handle remote posting.
- Post submissions.
- Configure the endpoint.
- Forward data.
- Handle the queue.
- Deliver submissions.
- Secure the endpoint.
- Provide remote submission posting.
