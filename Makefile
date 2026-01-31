.PHONY: up down clean

# Start the environment
up:
	@chmod +x scripts/startup.sh
	@./scripts/startup.sh

# Stop the Minikube VM to save RAM
down:
	@echo "🛑 Stopping Minikube..."
	@minikube stop
	@echo "✅ Environment stopped (RAM freed)."

# Delete the cluster entirely (Factory Reset)
clean:
	@echo "🧹 Deleting Minikube cluster..."
	@minikube delete
	@echo "✨ Cluster deleted. Run 'make up' to start fresh."