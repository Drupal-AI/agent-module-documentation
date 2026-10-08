# Configuration

Raisely is configured by entering the API credentials for your Raisely account so the
module can connect to the Raisely API. Because the module is under active development,
the exact form fields may change between releases — the essentials below hold in any
case.

## Enter your Raisely API credentials

Open the module's settings form (as an administrator) and enter the **API
credentials** issued by your Raisely account. The module uses these to authenticate
its requests to the Raisely API when fetching campaign and donation data.

## Store the credentials as secrets

The Raisely API credentials are sensitive — anyone who has them can act against your
Raisely account. Keep them out of the codebase:

- Do not hard‑code them or commit them to version control. Store them in an
  environment variable instead. On DDEV, the built‑in dotenv helper keeps them out of
  the repo:

  ```bash
  ddev dotenv set .ddev/.env --raisely-api-key='your-key'
  ddev restart
  ```

  (`.ddev/.env` must stay out of version control.)
- Where the module supports it, reference the credential through a **Key** entity
  backed by that environment variable rather than pasting the raw value into a
  configuration field.

## Mind the data flow

The module exchanges data with the external Raisely platform. Confirm that sending and
receiving that data is acceptable for your site's privacy requirements, and make sure
the connection runs over **HTTPS** so credentials and donation data are never sent in
the clear.
