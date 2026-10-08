<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
HTTP Status Code Test adds a configurable endpoint returning a status code.

---

HTTP Status Code Test **adds a configurable endpoint that returns a chosen HTTP status code** — useful for
testing monitoring/alerting, load balancers, or error-handling by making the site return e.g. 500/503/404 on
demand. It provides its own permissions, in the Development package.

Use it to test status-code handling. It is a developer/testing tool. Security note: an endpoint that can return
arbitrary status codes is for **testing** — gate it by its permission and don't leave it enabled on production
where it could be abused to fake outages/confuse monitoring. It has no content or access role beyond its
permission. Configure the test endpoint.

---

- Return a chosen HTTP status code.
- Provide a configurable test endpoint.
- Test monitoring/load balancers.
- Provide its own permissions.
- Serve development/testing.
- Return 500/503/404 on demand.
- USE it for testing only.
- Gate it by its permission.
- Not leave it on production (abuse/fake outages).
- Have no content/access role beyond permission.
- Configure the test endpoint.
- Handle the status endpoint.
- Return status codes.
- Configure the endpoint.
- Test statuses.
- Handle the testing.
- Fake statuses.
- Return codes.
- Keep it off production.
- Provide a status-code test endpoint.
