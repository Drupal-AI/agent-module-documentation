<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
HTTP Anti-virus submits uploaded files to a configurable HTTP endpoint (e.g. a scanning service) for anti-virus scanning before they are accepted.

---

HTTP Anti-virus (httpav) scans file uploads by submitting them to a configurable HTTP endpoint — a
virus-scanning service that accepts a file over HTTP and returns a verdict — so malicious uploads can be
rejected before they are stored. This lets sites integrate AV scanning (e.g. a containerized ClamAV
HTTP shim or a SaaS scanner) into Drupal's upload pipeline. It is in the Anti-virus package.

Use it to add malware scanning to user file uploads (a valuable defense where users can upload files).
The security-relevant configuration: point it at a trusted scanning endpoint over **TLS** (uploads and
verdicts traverse the network — checked, this module does not disable TLS verification), ensure the
endpoint is reachable and fails safe (decide whether an unreachable scanner should block or allow
uploads — prefer block/fail-closed for security), and treat scanning as one layer (not a guarantee).
Configure the endpoint and which upload fields are scanned.

---

- Scan file uploads for viruses.
- Submit uploads to an HTTP AV endpoint.
- Reject malicious uploads.
- Integrate ClamAV or a SaaS scanner.
- Add malware scanning to uploads.
- Point at a trusted endpoint over TLS.
- Ensure the scanner fails safe.
- Prefer fail-closed on scanner outage.
- Scan before storing files.
- Configure which fields are scanned.
- Treat scanning as one layer.
- Defend against malicious files.
- Return a verdict per file.
- Reject infected uploads.
- Protect the upload pipeline.
- Use a scanning service.
- Not disable TLS (checked).
- Block malware uploads.
- Configure the AV endpoint.
- Add AV to Drupal uploads.
