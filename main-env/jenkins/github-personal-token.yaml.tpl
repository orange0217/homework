apiVersion: v1
kind: Secret
metadata:
  name: github-personal-token
  labels:
    "jenkins.io/credentials-type": "secretText"
  annotations:
    "jenkins.io/credentials-description" : "github personal token"
type: Opaque
stringData:
  text: "${github_personal_token}"