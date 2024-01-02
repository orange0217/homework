#!/bin/bash  

# helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
##########################################install jenkins########################################
# install jenkins
helm repo add jenkins https://charts.jenkins.io
helm repo update

# create ns
kubectl create ns jenkins

# service account for kubernetes secret provider
kubectl apply -f /tmp/jenkins-service-account.yaml -n jenkins
# jenkins github personal access token
kubectl apply -f /tmp/github-personal-token.yaml -n jenkins

# jenkins github server(system) pat secret
kubectl apply -f /tmp/github-pat-secret-text.yaml -n jenkins

# install jenkins helm
helm upgrade -i jenkins jenkins/jenkins -n jenkins --create-namespace -f /tmp/jenkins-values.yaml --version "4.6.1"
##########################################install jenkins########################################

kubectl apply -f crossplane-tf-provider.yaml
kubectl apply -f crossplane-tf-provider-config.yaml

kubectl apply -f application-set.yaml