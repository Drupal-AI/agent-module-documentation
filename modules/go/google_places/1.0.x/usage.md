<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Google Places fetches data from Google Places.

---

Google Places **fetches data from the Google Places API** — looking up place details, autocomplete or search
results (addresses, businesses, geodata) from Google, usable in AI/automation or fields. It depends on the Key
module, in the AI Tools package.

Use it to query Google Places data. It is an integration feature and it handles secrets **correctly**: the
Google **API key** is stored via the **Key** module (secret provider), not plain config. Data-handling: queries
(which may include user-entered addresses) go to **Google** (external egress — over HTTPS), and Google's API
usage/quota costs money (guard against abuse). It has no access-control role. Configure the Google Places key.

---

- Fetch data from Google Places.
- Look up place details/search.
- Get addresses/businesses/geodata.
- Depend on the Key module.
- Serve integration.
- Use the Google Places API.
- Store the API key via the Key module (correct).
- Send queries to Google (egress) over HTTPS.
- Guard against quota abuse (costs money).
- Have no access-control role.
- Configure the Google Places key.
- Handle Google Places.
- Query places.
- Configure the client.
- Fetch places.
- Handle the integration.
- Look up places.
- Search places.
- Secure the key (Key module).
- Provide Google Places data.
