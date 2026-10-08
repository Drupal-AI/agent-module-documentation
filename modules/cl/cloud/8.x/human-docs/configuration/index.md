# Configuration

Setting up Cloud has three parts: grant the permissions, connect a cloud service
provider, and (for launching resources) walk the launch‑template workflow. The
framework's own settings form is small; most of the real configuration lives on
the provider entities you create.

## Grant permissions

Cloud defines its access in `cloud.permissions.yml`. On **People → Permissions**
assign, per role, the ones your team needs:

- **Administer cloud** — full control, including the settings form. Reserve this
  for administrators.
- **Access dashboard** — see the cloud dashboard.
- **View all cloud service providers** — see every configured provider.
- Per‑entity **view / list / add / edit / delete** permissions for the cloud
  resources (providers, launch templates, projects and so on), plus the
  **approve** permissions used by the launch workflow below.

## Open the settings form

Go to **Configuration → Web services → Cloud → Settings**
(`/admin/config/services/cloud/settings`); it requires the **Administer cloud**
permission. Most day‑to‑day behaviour is driven by the provider entities, but this
form holds framework‑wide options. One worth knowing is the **location map
geocoder**: set `cloud_location_geocoder_plugin` to a configured Geocoder
provider and Cloud will plot your providers' locations on a map (this uses the
`drupal/geocoder` module).

## Add a cloud service provider

Each cloud you manage is a *cloud service provider* (`cloud_config`) entity:

1. Go to **Structure → Cloud service providers → + Add cloud service provider**.
2. Choose the provider type and supply its credentials:
   - **AWS** offers three credential styles: *Use Instance Credentials* (an EC2
     IAM role, so no keys are stored in Drupal — the most secure option),
     *Simple access* (an Access key ID and Secret access key), or *Assume role*.
     Configure a least‑privilege IAM policy first; the README lists the EC2
     `Describe*` actions the dashboards need.
   - **Kubernetes, OpenStack and VMware** each take an API endpoint plus the
     appropriate token / kubeconfig or username and password.
3. Save. The credentials are stored on the `cloud_config` entity.
4. Run **cron** to import regions, images and existing resources from the
   provider into Drupal.

## The launch workflow

Launching resources is intentionally approval‑gated for governance:

1. Go to **Design → Launch template → *(provider)*** and create a
   `cloud_launch_template`.
2. Change its workflow status to **Approved** — this needs the relevant
   `approve launch …` permission, so approvals can be delegated to a reviewer
   role.
3. Click **Launch** (governed by the `launch cloud server template` /
   `launch approved cloud server template` permissions) to create the actual
   instance(s).

## Save

Each form saves independently with **Save**. Provider imports and dashboards
populate on the next cron run, so run cron (or wait for it) after connecting a new
provider to see its resources appear.
