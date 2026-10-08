<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Crowd Bruteforce Protection (cbp) is a hybrid security module that detects brute-force logins and vulnerability-scanner traffic, bans offending IPs through the core Ban module, and can optionally consult a crowd-sourced threat-intelligence server.

---

CBP 2.0.x combines two local detectors with optional cloud intelligence. It decorates Drupal's core `flood` service so failed-login floods (`user.failed_login_ip`) are noticed with zero request latency, and it subscribes to 404 (`NotFoundHttpException`) events to spot vulnerability scanners probing paths like `wp-login.php`. Detections are pushed onto the `cbp_flood_reporter` queue and reported asynchronously to a central API (`https://responsiveweb.io/cbp-v2/monitor`) by a cron queue worker; 404 scan reports are sent inline once a per-IP threshold is crossed. When the server confirms a high threat score, the IP is written to a local `cbp_watchlist` table and banned via `ban.ip_manager`. Watchlisted IPs are then banned locally on their next 404 ("strike two"). The design is fail-open: without an API key it runs as pure local flood/404 protection, and a circuit breaker suspends the queue if the API is unreachable. It requires the core `ban` module and supports Drupal 9, 10, and 11.

---

- Detect brute-force login attempts by decorating the core flood service.
- Ban IP addresses that exceed the core login flood limit.
- Detect vulnerability scanners by monitoring 404 responses.
- Ignore 404s for static assets (css, js, images, fonts) to reduce false positives.
- Distinguish real broken internal links from bot scans using the Referer header.
- Detect HTTP-to-HTTPS protocol-mismatch retries typical of bots.
- Report suspicious IPs asynchronously via the `cbp_flood_reporter` queue worker.
- Report 404 vulnerability scans to the central intelligence server after 10 hits/hour per IP.
- Consult a crowd-sourced threat-intelligence API for reputation scores.
- Maintain a local watchlist (`cbp_watchlist`) of confirmed high-threat IPs.
- Automatically ban IPs the server scores at or above the threshold via core Ban.
- Proactively re-ban a watchlisted IP the moment it triggers another 404.
- Run as local-only protection when no API key is configured (fail-open).
- Keep the site up when the API server is down (circuit breaker suspends the queue).
- Debounce repeat reports so one attacker cannot flood the queue.
- Provide an admin settings page to enter the API key.
- Provide an admin watchlist page listing banned/high-threat IPs and scores.
- Let admins remove an IP from the watchlist and unban it in one action.
- Log detection, banning, and API events to the `cbp` logger channel.
- Harden the login flow beyond core's default flood control.
- Contribute local detections to a shared, ecosystem-wide threat feed.
