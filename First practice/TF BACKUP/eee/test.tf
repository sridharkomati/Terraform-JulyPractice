resource "local_file" "foo" {
  content  = "foo!"
  filename = "${path.module}/test1.txt"
}