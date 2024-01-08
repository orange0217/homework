pipeline {
    agent none // 不在主节点上运行
    stages {
        stage('Deploy to Kubernetes') {
            //when {
            //    changeset "**/main-env/crossplane1/*.*"
            //}
            agent {
                kubernetes {
                    yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    app: kubectl
spec:
  serviceAccountName: jenkins
  containers:
  - name: kubectl-container
    image: lachlanevenson/k8s-kubectl
    command:
    - cat
    tty: true
"""
                }
            }
            steps {
                container('kubectl-container') {
                    sh 'pwd'
                    sh 'kubectl apply -f ./main-env/crossplane1/cluster2.yaml'
                    sh 'kubectl apply -f ./main-env/crossplane1/cluster3.yaml'
                }
            }
        }
    }
}