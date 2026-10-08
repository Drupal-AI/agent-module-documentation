<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ActiveNet is a thin read-only PHP client for the ACTIVE Network (ActiveNet) activity/registration REST API, exposed to Drupal code as a service.

---

ActiveNet provides a basic integration with ActiveNet — the ACTIVE Network activity-registration and
recreation-management platform — commonly used by YMCA Website Services sites to surface centers, sites,
activities, programs and membership data from ActiveNet inside Drupal. It ships one admin settings form
(base URI + API key) and a single service, `activenet.client`, built by `ActivenetClientFactory`, that
returns an `ActivenetClient` (a subclass of `GuzzleHttp\Client`). Calling code fetches JSON collections
through convenience methods such as `getCenters()`, `getActivities()` or `getActivityDetail($id)`; each
returns the decoded `body` of the ActiveNet response. The module has no UI beyond the settings form, no
blocks, no fields and no Views integration — it is a building block other modules or themes consume.

---

- Connect a Drupal site to an organization's ActiveNet (ACTIVE Network) account.
- Configure the ActiveNet API base URI and API key from the admin form.
- Fetch the list of centers with `getCenters()`.
- Fetch the list of sites/facilities with `getSites()`.
- List activities with `getActivities()` and filter via query arguments.
- Retrieve one activity's detail by id with `getActivityDetail($id)`.
- List activity types with `getActivityTypes()`.
- List activity "other" categories with `getActivityOtherCategories()`.
- List FlexReg programs with `getFlexRegPrograms()`.
- List FlexReg program types with `getFlexRegProgramTypes()`.
- List membership packages with `getMembershipPackages()`.
- List membership package categories with `getMembershipCategories()`.
- Inject the `activenet.client` service into a custom controller or block to render program listings.
- Pass ActiveNet query arguments (e.g. paging, filters) as an associative array to any list method.
- Build a YMCA program/schedule finder page backed by live ActiveNet data.
- Cache ActiveNet responses in your own consuming code to reduce API traffic.
- Provide activity data to a decoupled front end via a custom endpoint you write on top of the client.
- Restrict who can configure the connection using the "Administer ActiveNet" permission.
- Reuse the client from a `.theme` file or preprocess hook to populate template variables.
- Map ActiveNet activities into Drupal nodes or entities in a custom import you author.
- Surface membership options and pricing sourced from ActiveNet.
- Feed ActiveNet activity listings into a custom search or filter UI.
