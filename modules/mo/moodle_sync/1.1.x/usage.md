<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Moodle Sync uses Moodle webservices to sync data.

---

Moodle Sync **uses Moodle web services to sync data between Drupal and Moodle** — connecting to a Moodle LMS
to synchronize users, courses or enrolments, for integrated learning sites. It is in the Moodle Sync package.

Use it to integrate Drupal with Moodle. It is an integration feature. Security/data handling: it calls **Moodle's
web-service API** with a **web-service token** (store as a **secret** — env/Key — over HTTPS; the token grants
Moodle API access) and exchanges **user/enrolment data (PII)** — handle per your privacy obligations. It has no
access-control role. Configure the Moodle endpoint and token.

---

- Sync data with Moodle via web services.
- Synchronize users/courses/enrolments.
- Integrate an LMS.
- Use Moodle's web-service API.
- Serve integration.
- Connect Drupal and Moodle.
- Authenticate with a Moodle web-service token.
- Store the token as a secret over HTTPS.
- Exchange user/enrolment PII.
- Handle PII per privacy obligations.
- Have no access-control role.
- Configure the endpoint and token.
- Handle Moodle sync.
- Sync data.
- Configure the client.
- Sync users.
- Handle the integration.
- Connect Moodle.
- Secure the token.
- Provide Moodle sync.
