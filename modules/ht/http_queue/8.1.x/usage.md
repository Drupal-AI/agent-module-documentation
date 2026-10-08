<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
HTTP Queue queues outbound HTTP requests using Advanced Queue.

---

HTTP Queue **queues outbound HTTP requests** and processes them via Advanced Queue — so external API calls
(webhooks, integrations) can be made asynchronously and retried, rather than blocking the request. It depends
on the Advanced Queue module.

Use it to make external HTTP calls reliably/asynchronously. It is a developer/integration/operations feature.
Security note: outbound requests are made **with whatever URLs/credentials the enqueuing code provides** — so
ensure only trusted code enqueues requests, handle any target **credentials** as secrets, use **HTTPS**
targets, and (if request URLs can be influenced by input) guard against SSRF. It has no access-control role.
Enqueue HTTP requests from trusted code.

---

- Queue outbound HTTP requests.
- Process them via Advanced Queue.
- Make async, retryable calls.
- Depend on Advanced Queue.
- Avoid blocking the request.
- Serve webhooks/integrations.
- Ensure only trusted code enqueues.
- Handle target credentials as secrets.
- Use HTTPS + guard against SSRF.
- Have no access-control role.
- Enqueue from trusted code.
- Handle HTTP queuing.
- Queue requests.
- Configure the queue.
- Send async requests.
- Handle the queue.
- Make HTTP calls.
- Retry requests.
- Secure the targets.
- Provide HTTP queuing.
