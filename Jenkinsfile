node {
    def app


    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

        app = docker.build("api", "./simple_api/")
    }

    stage('Test image') {
        /* Ideally, we would run a test framework against our image.
         * For this example, we're using a Volkswagen-type approach ;-) */
        docker.image('api').withRun('-p 3000:5000 -v $PWD/simple_api/student_age.json:/data/student_age.json'){ c ->
        sh 'docker ps'
        sh 'curl -u toto:python 172.16.213.163:3000/pozos/api/v1.0/get_student_ages'
        }
    }

    stage("docker_scan"){
      sh '''
        docker rm db
        docker rm clair
        
        docker run -d --name db arminc/clair-db
        sleep 15 # wait for db to come up
        docker run -p 6060:6060 --link db:postgres -d --name clair arminc/clair-local-scan
        sleep 1

        clair-scanner --clair="http://clair:6060" api:latest
      '''
    }


    stage('Push image') {
        /* On push l'image sur notre server registry */
        docker.withRegistry('http://myregistry.local:5000/test') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }

    stage('Remove image') {
        /* On supprime l'image sur notre deployment server */
        docker rmi -f api:latest
    }


}
