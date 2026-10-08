# Configuration

Setting up the BrAPI server has two sides: deciding which data is exposed, and
controlling who can reach it.

## Permissions

BrAPI provides three permissions. Grant them to roles under **People →
Permissions** according to what each role should do:

- **`use brapi`** — read data through the BrAPI endpoints.
- **`edit brapi content`** — write/modify BrAPI data.
- **`administer brapi`** — set up the server, including which data types are
  exposed and how they are accessed.

Give `administer brapi` only to trusted administrators.

## Public pages vs. data access

Three pages are public by design and are meant to be:

- **`/brapi`** — the BrAPI landing page.
- **`/brapi/doc`** — the API documentation.
- **`/brapi/token`** — the page where clients obtain an authentication token.

Everything that returns actual breeding data is different: it uses **BrAPI token
authentication** combined with the permissions above. A client requests a token,
then sends it with each data request. Do not assume the public pages tell you
anything about data access — configure the data endpoints' access separately and
deliberately.

## Configure the exposed data types

Using the `administer brapi` screens, choose which BrAPI data types (germplasm,
studies, observations, and the rest of the specification) your site exposes, and
map them to your content. Configure the access for each so that only the intended
tokens and roles can read or edit them. Because this is the part of the module
that hands out breeding data over a standard API, review the access settings
carefully before pointing external tools at it.

## Verify

Obtain a token from `/brapi/token`, then call a BrAPI endpoint with it to confirm
that authenticated requests succeed and that unauthenticated or under-privileged
requests are refused as you expect.
