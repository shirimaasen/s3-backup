# Backup Script

This `backup.sh` script allows you to perform backup and restore operations between two AWS S3 buckets. It reads a list of folders from a specified file and either backs them up from a source bucket to a backup bucket or restores them from a backup bucket to the source bucket.

## Prerequisites

- AWS CLI configured with appropriate permissions to access the specified S3 buckets.
- Bash shell environment.

## Script Parameters

The script accepts the following parameters:

- `--operation`: The operation to perform (`backup` or `restore`).
- `--backup-bucket`: The name of the S3 bucket where the data will be backed up or restored from.
- `--source-bucket`: The name of the S3 bucket where the data will be backed up from or restored to.
- `--list-file`: The file containing a list of folders to be backed up or restored.
- `--region`: The AWS region where both S3 buckets are located.

## Usage

## Running the Script

```
chmod +x backup.sh
```

### Example Command

Execute the script with the required parameters:

```bash
backup.sh --operation backup --backup-bucket Backup2 --source-bucket Source1 --list-file backup.list --region eu-west-1
```

Follow the on-screen prompts to confirm the operation.

## Script Workflow
- Parameter Check: The script checks if any parameters are provided. If none, it displays the usage instructions and exits.
- Parameter Parsing: The script parses the provided parameters and assigns them to appropriate variables.
- Confirmation: The script displays the parsed parameters and asks for user confirmation to proceed.
- Operation Execution:
    - If the operation is `backup`, the script reads the list of folders from the specified file and uses the `aws s3 sync` command to back them up from the source bucket to the backup bucket.
    - If the operation is `restore`, the script reads the list of folders from the specified file and uses the `aws s3 sync` command to restore them from the backup bucket to the source bucket.
## Example backup.list File
The `backup.list` file should contain the paths of the folders to be backed up or restored, one per line. For example:

```bash
s3://bucket-raw/folder1
s3://bucket-raw/folder2
s3://bucket-raw/folder3
```
