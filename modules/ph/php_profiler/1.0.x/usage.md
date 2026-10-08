<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PHP Profiler profiles Drupal with XHProf and uploads results to XHGui.

---

PHP Profiler **profiles Drupal with XHProf and uploads the results to XHGui** — capturing detailed runtime
performance data (function call graphs, timings, memory) via the `perftools/php-profiler` package and sending it to
an XHGui instance for analysis. It depends on the XHProf module and provides its own permissions, in the
Development package.

Use it to diagnose performance in development. It is a **developer/diagnostic** tool with clear operational
guidance: profiling data is **detailed and potentially sensitive** (it can reveal code paths, and depending on
configuration, arguments/queries), and it is **sent to an XHGui server** (egress). So keep it to
**non-production/development** environments, ensure the XHGui destination is a **trusted, access-controlled**
endpoint (don't ship profiling data to an untrusted host), gate its permission to developers, and disable it in
production (profiling also adds overhead). It has no content or access role. Configure the XHGui endpoint.

---

- Profile Drupal with XHProf.
- Capture call graphs/timings/memory.
- Upload results to XHGui.
- Depend on the XHProf module.
- Provide its own permissions.
- Serve development/diagnostics.
- CAPTURE detailed, potentially sensitive runtime data.
- SEND profiling data to an XHGui server (egress).
- Keep to non-production/development + a trusted, access-controlled XHGui.
- Gate its permission to developers + disable in production (overhead).
- Have no content/access role.
- Configure the XHGui endpoint.
- Handle profiling.
- Profile requests.
- Configure the endpoint.
- Capture traces.
- Handle the upload.
- Analyze performance.
- Keep it dev-only.
- Provide XHProf profiling.
