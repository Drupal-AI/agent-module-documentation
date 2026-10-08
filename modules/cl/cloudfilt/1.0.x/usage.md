<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CloudFilt prevents bot traffic, scraping, Tor, spam, fraud and DDoS.

---

CloudFilt is a **security middleware** that checks incoming traffic against the **CloudFilt** threat service
— on each request it queries CloudFilt with the visitor's IP and blocks traffic identified as bots, web
scraping, Tor, spam submissions, fraud or DDoS. It integrates via a StackMiddleware.

Use it to filter malicious traffic. This is a **security-positive** protection layer. Things to know:
security/data handling — it sends the **visitor's IP** to the CloudFilt API (external egress; an IP is personal
data — disclose it) and authenticates with a **CloudFilt API key** (store as a **secret** over HTTPS);
operationally — because it makes an outbound HTTP call **on every request**, it adds latency and a dependency, so
confirm its fail-open/fail-closed behaviour if CloudFilt is unreachable (you don't want to lock out all traffic
on an outage). It has no Drupal access-control role; it filters at the edge. Configure the CloudFilt API key.

---

- Filter malicious traffic.
- Block bots/scrapers/Tor/spam/DDoS.
- Query CloudFilt per request.
- Integrate via StackMiddleware.
- BE security-positive.
- Check the visitor's IP.
- Send the IP to CloudFilt (egress; personal data).
- Store the CloudFilt API key as a secret.
- Confirm fail-open/closed on outage.
- Add latency (per-request outbound call).
- Have no Drupal access-control role.
- Configure the API key.
- Handle traffic filtering.
- Block bad traffic.
- Configure CloudFilt.
- Filter requests.
- Handle the integration.
- Stop bots.
- Secure the key.
- Provide traffic filtering.
