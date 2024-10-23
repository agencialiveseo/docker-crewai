# liveseo/crewai Docker Image Documentation

Welcome to the unofficial Docker image documentation for **crewai**. This image is designed to simplify the use of the [CrewAI](https://github.com/CrewAI) toolset in Python projects. Below are detailed instructions on how to build, run, and customize this image for your own use cases.

[![CrewAI Logo](https://github.com/crewAIInc/crewAI/raw/main/docs/crewai_logo.png)](https://github.com/crewaiinc/crewai)

## 1. Image Overview

This Docker image is based on **Python 3.11** (bookworm) and comes pre-configured with the CrewAI toolset. The image is flexible, allowing you to override the default application with your own scripts.

### Key Features:
- Python 3.11 (Bookworm)
- Pre-installed CrewAI tools (`crewai[tools]`)
- Support for custom application scripts
- <del>Lightweight and</del> customizable

## 2. Build the Docker Image

To create a Docker image using this repository, run the following command in the directory where the `Dockerfile` and `app.py` files are located:

```bash
docker build -t crewai .
```

## 3. Run the Docker Container

To run a container using the built image, you can use the following command:

```bash
docker run --name crewai-app -v $(pwd)/app:/app -d crewai
```

Or, you can use the pre-built image from Docker Hub:

```bash
docker run --name crewai-app -v $(pwd)/app:/app -d liveseo/crewai
```

### Explanation:
- `--name crewai-app`: Gives the container a name for easier management.
- `-v $(pwd)/app:/app`: Mounts your local `app` directory to the `/app` directory inside the container, allowing you to persist or modify scripts externally.
- `-d`: Runs the container in detached mode, meaning it will run in the background.

## 4. Using this Image as a Base for Your Own Projects

If you want to use **liveseo/crewai** as a base image for your own Dockerfile, you can do so by referencing it in the `FROM` statement:

```Dockerfile
FROM liveseo/crewai

# Add your custom application setup here
COPY ./my_app.py /app/app.py

CMD ["python", "/app/my_app.py"]
```

### Explanation:
- This allows you to extend the functionality of the `crewai` image and add your own scripts or applications on top.

## 5. Using crewai CLI

If you want to use the `crewai` CLI tool, you can run the following command in a running container:

```bash
docker exec -it crewai-app crewai --help
```

Or, you can run the following command to create a container with an interactive shell:

```bash
docker run --name crewai-app -v $(pwd)/app:/app -it liveseo/crewai bash
```

### Explanation:
- `docker exec -it crewai-app crewai --help`: Runs the `crewai` CLI tool inside the running container.
- `docker run --name crewai-app -v $(pwd)/app:/app -it liveseo/crewai bash`: Creates a new container with an interactive shell, allowing you to run commands inside the container. The mapped volume allows you to access the `/app` directory from your host.

---

## 6. **liveseo/crewai:dev** - Development Image with VSCode

We also provide a development version of the image that includes **VSCode** running on port **8080** with access to the terminal, allowing for real-time editing and terminal interaction directly in your browser.

To run the development version, use the following command:

```bash
docker run -d -p 0.0.0.0:8080:8080 --name crewai-dev -v $(pwd)/app:/app liveseo/crewai:dev
```

### Explanation:
- `-p 0.0.0.0:8080:8080`: Maps port 8080 of the container to port 8080 of the host, making VSCode accessible from your browser at `localhost:8080`.
- `-v $(pwd)/app:/app`: Mounts your local `app` directory into the container, so all your project files are accessible and editable via VSCode in the browser.
- `--name crewai-dev`: Names the container for easier management.

Once the container is running, open a web browser and go to:

```
http://localhost:8080
```

This will open VSCode in your browser, allowing you to:
- Access the terminal
- Edit files in the `/app` directory
- Run commands and test your application in real-time

### Example Workflow for Development:
1. Start the container with the command above.
2. Open `localhost:8080` in your browser.
3. Use the VSCode terminal to run your Python scripts or interact with CrewAI tools.
4. Edit files in `/app` as needed.
5. Any changes in the host machine's `app` directory will be immediately reflected inside the container due to the volume mount.

---

This Docker image provides a flexible and convenient way to work with the CrewAI toolset. You can run it out of the box or customize it to fit your specific needs using Docker volumes or Docker Compose.

For more information on how to use CrewAI, please refer to the [Official CrewAI](https://github.com/crewaiinc/crewai).