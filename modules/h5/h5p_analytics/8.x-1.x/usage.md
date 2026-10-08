<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
H5P Analytics provides H5P xAPI LRS integration.

---

H5P Analytics **sends H5P interaction data (xAPI statements) to a Learning Record Store (LRS)** — so learner
interactions with H5P content (quizzes, videos) are recorded in an external LRS for learning analytics, with an
`h5p_analytics_tip` submodule. It depends on the H5P module, in the H5P package.

Use it to track H5P learning interactions in an LRS. It is an e-learning/integration feature. Security/data
handling: xAPI statements contain **learner identifiers and interaction data (PII/learning records)** sent to
an **external LRS** — handle the LRS **endpoint credentials** as secrets, use HTTPS, and treat learner data per
your privacy policy (learning records are sensitive personal data). It has no access-control role. Configure the
LRS endpoint and credentials.

---

- Send H5P xAPI data to an LRS.
- Record learner interactions.
- Support learning analytics.
- Provide a tip submodule.
- Depend on the H5P module.
- Track quizzes/videos.
- Send learner PII/records to an external LRS.
- Handle LRS credentials as secrets.
- Use HTTPS + privacy policy.
- Have no access-control role.
- Configure the LRS endpoint.
- Handle H5P analytics.
- Track interactions.
- Configure the LRS.
- Send xAPI.
- Handle the integration.
- Record learning.
- Send statements.
- Secure the credentials.
- Provide H5P analytics.
