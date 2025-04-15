terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.0"
    }
  }
}

# Generate a random pet name
resource "random_pet" "example" {
  length    = 2
  separator = "-"
}

resource "random_pet" "example2" {
  length    = 6
  separator = ":"
}

# Create a local file with content from the random pet name
resource "local_file" "example" {
  filename = "${path.module}/output.txt"
  content  = "Hello, Terraform! Your random pet name is: ${random_pet.example.id}"
}

# Resource to print date every second for 60 seconds
resource "null_resource" "print_date" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = <<EOT
      for i in $(seq 1 60); do
        date
        sleep 1
      done
    EOT
  }
}


# Output the generated random pet name
output "pet_name" {
  value = random_pet.example.id
}

# Output the path to the created file
output "file_path" {
  value = local_file.example.filename
}

