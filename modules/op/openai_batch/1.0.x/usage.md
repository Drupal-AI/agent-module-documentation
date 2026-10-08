<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
OpenAI Batch provides Drupal integration for OpenAI's Batch API.

---

OpenAI Batch provides **Drupal integration for OpenAI's Batch API** — submitting large sets of requests to
OpenAI as an asynchronous batch job (cheaper/bulk processing) and collecting results, with Views Bulk Operations
integration. It depends on the AI module, AI Provider OpenAI and Views Bulk Operations, provides its own
permissions, in the Custom package.

Use it to bulk-process content through OpenAI. It is an AI/integration feature. Security/data handling: it
**sends content to OpenAI** in batch (external egress — confirm acceptable for potentially large/sensitive
content), the **API key** lives in the AI module's Key config (secret), and running batches is a privileged
action (gate its permission; batches can incur cost). It has no access-control role beyond its permission.
Configure the OpenAI provider and batches.

---

- Integrate OpenAI's Batch API.
- Submit async batch jobs.
- Bulk-process via VBO.
- Depend on AI/AI Provider OpenAI/VBO.
- Provide its own permissions.
- Collect batch results.
- Send content to OpenAI in batch (egress).
- Confirm acceptable for large/sensitive content.
- Keep the API key in AI/Key (secret).
- Gate the permission (batches incur cost).
- Have no access-control role beyond permission.
- Configure the provider and batches.
- Handle OpenAI batches.
- Batch-process.
- Configure the batches.
- Send batches.
- Handle the integration.
- Process content.
- Secure the key.
- Provide OpenAI batch processing.
