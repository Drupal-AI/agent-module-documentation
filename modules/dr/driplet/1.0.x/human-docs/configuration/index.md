# Configuration

Driplet's configuration ties three things together: the **JWT signing secret**
that authenticates users to the microservice, the **connection details** for the
running Driplet microservice, and the topics/targets you use when you push
messages from code.

## Set the JWT signing secret

When a user connects, Drupal issues them a JWT (from the `/api/driplet/jwt`
endpoint) that encodes their user ID and roles; the Driplet microservice uses
that token to identify the user and decide which messages reach them. The token
is signed with a secret held in configuration (`driplet_jwt_secret`).

The module ships a placeholder default for this value. Replace it with a strong,
unique, randomly generated string on Driplet's settings form before you go live,
and configure the **same secret** on the Driplet microservice — if the two do not
match, token verification fails. Since the value lives in configuration, keep your
exported config out of any location you would not want that secret to appear, and
control who can edit these settings.

## Point Drupal at the microservice

On Driplet's settings form (under **Configuration**), set the connection details
for your running Driplet microservice so the module knows where to push messages
and where the frontend client should open its WebSocket connection. These values
must match how you configured the microservice (see the module's `README.md`).

## Targeting messages (from code)

When you send a message through the `driplet.service` PHP service you choose:

- a **topic** — a label that groups related messages; frontend clients subscribe
  to the topics relevant to the page they're viewing, and receive only those;
- a **target** — who should receive it: specific user IDs, one or more roles, or a
  combination. The targeting can also be **inverted** to specify exclusion
  criteria (everyone *except* a given set).

This targeting is expressed in code rather than on an admin form; the
`driplet_notify` submodule is a working example to copy from.
