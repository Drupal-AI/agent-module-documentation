# Configuration

## Connect to your storage account

Open the module's settings form (route `azure_storage.settings_form`) as a user with
its administration permission, and enter your Azure Storage account name, the container
to use, and the credential.

### Keep the account key a secret

The **account key** / **connection string** is a secret that grants access to your
storage. Do **not** put it in plaintext configuration, and never place it in the
webroot. Supply it from the environment:

```bash
ddev dotenv set .ddev/.env --azure-storage-key=<value>
ddev restart
```

(The flag becomes the variable `AZURE_STORAGE_KEY`. Never commit `.ddev/.env`.)
Reference it from Drupal via `getenv('AZURE_STORAGE_KEY')`, or a Key entity backed by
the env provider. The account name and container name are not secret and can live in
ordinary config.

## Set container access to match file privacy

Azure Blob containers can expose their blobs publicly or keep them private. Match this
to the files you store:

- If you store **public** files (images, downloads meant for everyone), public blob
  access is fine.
- If you store **private** files, the container's blobs **must not** be publicly
  readable — otherwise anyone with the URL could bypass Drupal's access checks and read
  them directly from Azure.

## Using it for Drupal files

Once connected, files written through the module's Azure stream wrapper are stored in
and served from the container. Requests to Azure use TLS (the module does not disable
certificate verification). You can point specific file fields or the whole file system
at Azure depending on how you want to offload storage.
