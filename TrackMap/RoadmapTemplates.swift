import Foundation

struct RoadmapTemplates {

    static func createDeepLearningLLMsAgentsRoadmap(
        withTitle title: String = "Deep Learning, LLMs, and AI Agents Roadmap",
        description: String = "A comprehensive guide to mastering deep learning, large language models (LLMs), and building intelligent agents.",
        imageName: String = "brain.head.profile"
    ) -> Roadmap {
        return Roadmap(
            id: UUID(),
            title: title,
            description: description,
            imageName: imageName,
            phases: [

                // Phase 1: Introduction to Deep Learning
                Phase(name: "Phase 1: Introduction to Deep Learning", tasks: [
                    Task(name: "Neural Networks Basics", isCompleted: false, subTasks: [
                        SubTask(name: "Understand Neurons and Activation Functions", isCompleted: false),
                        SubTask(name: "Learn Feedforward Neural Networks", isCompleted: false),
                        SubTask(name: "Implement a Basic Neural Network from Scratch", isCompleted: false)
                    ]),
                    Task(name: "Backpropagation and Gradient Descent", isCompleted: false, subTasks: [
                        SubTask(name: "Understand Backpropagation", isCompleted: false),
                        SubTask(name: "Implement Gradient Descent", isCompleted: false),
                        SubTask(name: "Fine-tune the Neural Network", isCompleted: false)
                    ]),
                    Task(name: "Advanced Neural Networks", isCompleted: false, subTasks: [
                        SubTask(name: "Implement Multi-Layer Perceptron (MLP)", isCompleted: false),
                        SubTask(name: "Understand Batch Normalization and Dropout", isCompleted: false),
                        SubTask(name: "Experiment with Optimization Techniques", isCompleted: false)
                    ])
                ]),

                // Phase 2: Convolutional Neural Networks (CNNs)
                Phase(name: "Phase 2: Convolutional Neural Networks (CNNs)", tasks: [
                    Task(name: "Learn CNN Architecture", isCompleted: false, subTasks: [
                        SubTask(name: "Understand Convolution, Pooling, and Fully Connected Layers", isCompleted: false),
                        SubTask(name: "Explore CNN for Image Classification", isCompleted: false),
                        SubTask(name: "Implement a CNN for Basic Image Recognition", isCompleted: false)
                    ]),
                    Task(name: "Transfer Learning and Fine-Tuning", isCompleted: false, subTasks: [
                        SubTask(name: "Learn about Pre-trained Models (VGG, ResNet)", isCompleted: false),
                        SubTask(name: "Fine-Tune Models for Specific Tasks", isCompleted: false)
                    ]),
                    Task(name: "Object Detection & Segmentation", isCompleted: false, subTasks: [
                        SubTask(name: "Understand R-CNN, YOLO", isCompleted: false),
                        SubTask(name: "Implement Object Detection", isCompleted: false)
                    ])
                ]),

                // Phase 3: Recurrent Neural Networks (RNNs) & LSTMs
                Phase(name: "Phase 3: RNNs & LSTMs", tasks: [
                    Task(name: "Learn RNN Basics", isCompleted: false, subTasks: [
                        SubTask(name: "Understand Time-Series Data", isCompleted: false),
                        SubTask(name: "Build a Simple RNN for Sequence Prediction", isCompleted: false)
                    ]),
                    Task(name: "LSTM and GRU Networks", isCompleted: false, subTasks: [
                        SubTask(name: "Learn LSTM Networks", isCompleted: false),
                        SubTask(name: "Implement LSTM for Text Generation", isCompleted: false)
                    ]),
                    Task(name: "Bidirectional RNNs", isCompleted: false, subTasks: [
                        SubTask(name: "Understand Bidirectional RNN", isCompleted: false),
                        SubTask(name: "Build Bidirectional LSTM for Sentiment Analysis", isCompleted: false)
                    ])
                ]),

                // Phase 4: Transformers and Attention Mechanism
                Phase(name: "Phase 4: Transformers & Attention", tasks: [
                    Task(name: "Learn Transformer Architecture", isCompleted: false, subTasks: [
                        SubTask(name: "Understand Attention Mechanism", isCompleted: false),
                        SubTask(name: "Study Multi-head Attention", isCompleted: false),
                        SubTask(name: "Understand Positional Encoding", isCompleted: false)
                    ]),
                    Task(name: "BERT and GPT Models", isCompleted: false, subTasks: [
                        SubTask(name: "Understand BERT Architecture", isCompleted: false),
                        SubTask(name: "Understand GPT Models", isCompleted: false),
                        SubTask(name: "Fine-Tune BERT for Text Classification", isCompleted: false)
                    ]),
                    Task(name: "Implementing Transformers from Scratch", isCompleted: false, subTasks: [
                        SubTask(name: "Build a Transformer from Scratch", isCompleted: false),
                        SubTask(name: "Apply Transformers for NLP Tasks", isCompleted: false)
                    ])
                ]),

                // Phase 5: Large Language Models (LLMs)
                Phase(name: "Phase 5: Large Language Models (LLMs)", tasks: [
                    Task(name: "Learn about LLMs", isCompleted: false, subTasks: [
                        SubTask(name: "Understand GPT, BERT, and T5", isCompleted: false),
                        SubTask(name: "Study Tokenization Techniques (Byte Pair Encoding, SentencePiece)", isCompleted: false)
                    ]),
                    Task(name: "Fine-Tune Pre-trained LLMs", isCompleted: false, subTasks: [
                        SubTask(name: "Fine-Tune GPT for Text Generation", isCompleted: false),
                        SubTask(name: "Fine-Tune BERT for Question Answering", isCompleted: false)
                    ]),
                    Task(name: "Implement Hugging Face Transformers", isCompleted: false, subTasks: [
                        SubTask(name: "Set up Hugging Face Transformers Library", isCompleted: false),
                        SubTask(name: "Fine-tune Pre-trained Models", isCompleted: false),
                        SubTask(name: "Use Hugging Face for Text Generation", isCompleted: false)
                    ])
                ]),

                // Phase 6: LangChain & RAG (Retrieval Augmented Generation)
                Phase(name: "Phase 6: LangChain & RAG", tasks: [
                    Task(name: "Learn LangChain", isCompleted: false, subTasks: [
                        SubTask(name: "Understand LangChain Concepts", isCompleted: false),
                        SubTask(name: "Integrate LangChain with LLMs", isCompleted: false)
                    ]),
                    Task(name: "Implement RAG (Retrieval Augmented Generation)", isCompleted: false, subTasks: [
                        SubTask(name: "Understand RAG for Text Retrieval", isCompleted: false),
                        SubTask(name: "Implement RAG for Enhanced Text Generation", isCompleted: false)
                    ]),
                    Task(name: "Create a Custom Chatbot with LangChain", isCompleted: false, subTasks: [
                        SubTask(name: "Set Up LangChain for Chatbot", isCompleted: false),
                        SubTask(name: "Integrate LLM into the Chatbot", isCompleted: false)
                    ])
                ]),

                // Phase 7: AI Agents and Advanced Use-Cases
                Phase(name: "Phase 7: AI Agents & Use-Cases", tasks: [
                    Task(name: "Understand AI Agent Concepts", isCompleted: false, subTasks: [
                        SubTask(name: "Learn about Autonomous Agents", isCompleted: false),
                        SubTask(name: "Understand Decision Making and Reasoning", isCompleted: false)
                    ]),
                    Task(name: "Building a Conversational AI Agent", isCompleted: false, subTasks: [
                        SubTask(name: "Design a Rule-Based System", isCompleted: false),
                        SubTask(name: "Implement Reinforcement Learning for AI Agents", isCompleted: false)
                    ]),
                    Task(name: "Deploy AI Agents", isCompleted: false, subTasks: [
                        SubTask(name: "Integrate with Web Apps", isCompleted: false),
                        SubTask(name: "Deploy on Cloud (AWS, GCP, Azure)", isCompleted: false)
                    ])
                ])
            ]
        )
    }

    static func createMLAndMLOpsRoadmap(
        withTitle title: String = "ML & MLOps Roadmap",
        description: String = "A step-by-step guide to mastering traditional Machine Learning techniques and operationalizing ML models in production.",
        imageName: String = "gearshape.2.fill"
    ) -> Roadmap {
        return Roadmap(
            id: UUID(),
            title: title,
            description: description,
            imageName: imageName,
            phases: [

                // Phase 1: Machine Learning Fundamentals
                Phase(name: "Phase 1: ML Fundamentals", tasks: [
                    Task(name: "Understand ML Pipeline", isCompleted: false, subTasks: [
                        SubTask(name: "Problem Framing", isCompleted: false),
                        SubTask(name: "Data Collection & Cleaning", isCompleted: false),
                        SubTask(name: "Feature Engineering", isCompleted: false),
                        SubTask(name: "Model Selection", isCompleted: false),
                        SubTask(name: "Model Evaluation", isCompleted: false)
                    ]),
                    Task(name: "Supervised vs Unsupervised Learning", isCompleted: false, subTasks: [
                        SubTask(name: "Learn Regression (Linear, Logistic)", isCompleted: false),
                        SubTask(name: "Learn Classification (SVM, KNN, Decision Trees)", isCompleted: false),
                        SubTask(name: "Understand Clustering (KMeans, DBSCAN)", isCompleted: false),
                        SubTask(name: "Understand Dimensionality Reduction (PCA, t-SNE)", isCompleted: false)
                    ]),
                    Task(name: "Model Evaluation Metrics", isCompleted: false, subTasks: [
                        SubTask(name: "Confusion Matrix, Precision, Recall", isCompleted: false),
                        SubTask(name: "F1 Score, ROC-AUC", isCompleted: false),
                        SubTask(name: "Cross Validation & Grid Search", isCompleted: false)
                    ])
                ]),

                // Phase 2: Real-World ML with Sklearn
                Phase(name: "Phase 2: Real-World ML with Sklearn", tasks: [
                    Task(name: "Hands-on with scikit-learn", isCompleted: false, subTasks: [
                        SubTask(name: "Build Pipeline using ColumnTransformer", isCompleted: false),
                        SubTask(name: "Apply OneHotEncoding, Imputation", isCompleted: false),
                        SubTask(name: "Model Training & Evaluation", isCompleted: false)
                    ]),
                    Task(name: "Advanced ML Techniques", isCompleted: false, subTasks: [
                        SubTask(name: "Ensemble Methods (Bagging, Boosting)", isCompleted: false),
                        SubTask(name: "Learn Random Forests, XGBoost, LightGBM", isCompleted: false),
                        SubTask(name: "Apply Feature Importance Techniques", isCompleted: false)
                    ])
                ]),

                // Phase 3: ML in Production
                Phase(name: "Phase 3: ML in Production", tasks: [
                    Task(name: "Structuring ML Projects", isCompleted: false, subTasks: [
                        SubTask(name: "Understand Cookiecutter Structure", isCompleted: false),
                        SubTask(name: "Modularize Code (Training, Inference)", isCompleted: false),
                        SubTask(name: "Use Hydra or Config Libraries", isCompleted: false)
                    ]),
                    Task(name: "Version Control & Experiment Tracking", isCompleted: false, subTasks: [
                        SubTask(name: "Track Experiments with MLflow", isCompleted: false),
                        SubTask(name: "Use DVC for Data and Model Versioning", isCompleted: false),
                        SubTask(name: "Collaborate Using Git + DVC", isCompleted: false)
                    ]),
                    Task(name: "Deployment with FastAPI & Docker", isCompleted: false, subTasks: [
                        SubTask(name: "Create API with FastAPI", isCompleted: false),
                        SubTask(name: "Dockerize the API", isCompleted: false),
                        SubTask(name: "Test API Locally and on Cloud", isCompleted: false)
                    ])
                ]),

                // Phase 4: Monitoring and CI/CD
                Phase(name: "Phase 4: Monitoring and CI/CD", tasks: [
                    Task(name: "Set Up CI/CD for ML", isCompleted: false, subTasks: [
                        SubTask(name: "Use GitHub Actions for Testing", isCompleted: false),
                        SubTask(name: "Automate Linting and Formatting", isCompleted: false),
                        SubTask(name: "Trigger Model Retraining", isCompleted: false)
                    ]),
                    Task(name: "Model Monitoring in Production", isCompleted: false, subTasks: [
                        SubTask(name: "Log Predictions with Prometheus", isCompleted: false),
                        SubTask(name: "Set Up Grafana Dashboards", isCompleted: false),
                        SubTask(name: "Capture Drift & Trigger Retraining", isCompleted: false)
                    ]),
                    Task(name: "Feedback Loops & Automation", isCompleted: false, subTasks: [
                        SubTask(name: "Enable Human-in-the-loop Feedback", isCompleted: false),
                        SubTask(name: "Automate Retraining Pipelines", isCompleted: false)
                    ])
                ])
            ]
        )
    }

    static func createPythonRoadmap(
        withTitle title: String = "Python Mastery Roadmap",
        description: String = "A hands-on, practical path to master Python for scripting, automation, backend dev, and data science.",
        imageName: String = "chevron.left.forwardslash.chevron.right"
    ) -> Roadmap {
        return Roadmap(
            id: UUID(),
            title: title,
            description: description,
            imageName: imageName,
            phases: [

                // Phase 1: Python Foundations
                Phase(name: "Phase 1: Python Foundations", tasks: [
                    Task(name: "Python Setup & Environment", isCompleted: false, subTasks: [
                        SubTask(name: "Install Python & Setup VS Code", isCompleted: false),
                        SubTask(name: "Use virtual environments", isCompleted: false),
                        SubTask(name: "Write and run Python scripts", isCompleted: false)
                    ]),
                    Task(name: "Python Basics", isCompleted: false, subTasks: [
                        SubTask(name: "Variables & Data Types", isCompleted: false),
                        SubTask(name: "Basic Operators & Expressions", isCompleted: false),
                        SubTask(name: "Control Flow: if/else, loops", isCompleted: false),
                        SubTask(name: "Functions: def, return, args, kwargs", isCompleted: false)
                    ]),
                    Task(name: "Working with Data Structures", isCompleted: false, subTasks: [
                        SubTask(name: "Lists, Tuples, Sets, Dictionaries", isCompleted: false),
                        SubTask(name: "List comprehensions", isCompleted: false),
                        SubTask(name: "Slicing & unpacking", isCompleted: false)
                    ])
                ]),

                // Phase 2: Intermediate Python
                Phase(name: "Phase 2: Intermediate Python", tasks: [
                    Task(name: "Modules & Packages", isCompleted: false, subTasks: [
                        SubTask(name: "Importing built-in and external modules", isCompleted: false),
                        SubTask(name: "Creating your own modules", isCompleted: false),
                        SubTask(name: "Using pip & virtualenv", isCompleted: false)
                    ]),
                    Task(name: "Error Handling", isCompleted: false, subTasks: [
                        SubTask(name: "Try-Except blocks", isCompleted: false),
                        SubTask(name: "Finally, else, raising exceptions", isCompleted: false),
                        SubTask(name: "Custom exception classes", isCompleted: false)
                    ]),
                    Task(name: "File I/O", isCompleted: false, subTasks: [
                        SubTask(name: "Reading and writing files", isCompleted: false),
                        SubTask(name: "Working with CSV and JSON", isCompleted: false),
                        SubTask(name: "Using context managers (`with open()`)", isCompleted: false)
                    ])
                ]),

                // Phase 3: Object-Oriented Programming (OOP)
                Phase(name: "Phase 3: Object-Oriented Programming (OOP)", tasks: [
                    Task(name: "OOP Concepts", isCompleted: false, subTasks: [
                        SubTask(name: "Classes and objects", isCompleted: false),
                        SubTask(name: "Attributes and methods", isCompleted: false),
                        SubTask(name: "`__init__` and `__str__`", isCompleted: false)
                    ]),
                    Task(name: "Inheritance & Polymorphism", isCompleted: false, subTasks: [
                        SubTask(name: "Single and multiple inheritance", isCompleted: false),
                        SubTask(name: "Method overriding and super()", isCompleted: false)
                    ]),
                    Task(name: "Advanced OOP", isCompleted: false, subTasks: [
                        SubTask(name: "Magic/Dunder methods", isCompleted: false),
                        SubTask(name: "Encapsulation and private members", isCompleted: false),
                        SubTask(name: "Classmethods and staticmethods", isCompleted: false)
                    ])
                ]),

                // Phase 4: Python for Scripting & Automation
                Phase(name: "Phase 4: Python for Scripting & Automation", tasks: [
                    Task(name: "Automate Everyday Tasks", isCompleted: false, subTasks: [
                        SubTask(name: "Batch file renaming", isCompleted: false),
                        SubTask(name: "Automating email reports", isCompleted: false),
                        SubTask(name: "Web scraping basics with `requests` and `BeautifulSoup`", isCompleted: false)
                    ]),
                    Task(name: "System & OS Interaction", isCompleted: false, subTasks: [
                        SubTask(name: "Use the `os`, `sys`, and `shutil` modules", isCompleted: false),
                        SubTask(name: "Reading environment variables", isCompleted: false),
                        SubTask(name: "Automating backups or tasks", isCompleted: false)
                    ])
                ]),

                // Phase 5: Python for Data Analysis
                Phase(name: "Phase 5: Python for Data Analysis", tasks: [
                    Task(name: "NumPy Basics", isCompleted: false, subTasks: [
                        SubTask(name: "Arrays and vector operations", isCompleted: false),
                        SubTask(name: "Broadcasting and slicing", isCompleted: false)
                    ]),
                    Task(name: "Pandas Fundamentals", isCompleted: false, subTasks: [
                        SubTask(name: "DataFrames and Series", isCompleted: false),
                        SubTask(name: "Reading/writing CSV, Excel, SQL", isCompleted: false),
                        SubTask(name: "Indexing, filtering, groupby", isCompleted: false)
                    ]),
                    Task(name: "Visualization with Matplotlib & Seaborn", isCompleted: false, subTasks: [
                        SubTask(name: "Line, bar, scatter, histograms", isCompleted: false),
                        SubTask(name: "Seaborn for heatmaps and pair plots", isCompleted: false)
                    ])
                ]),

                // Phase 6: Advanced Python Concepts
                Phase(name: "Phase 6: Advanced Python Concepts", tasks: [
                    Task(name: "Decorators & Generators", isCompleted: false, subTasks: [
                        SubTask(name: "Writing and using decorators", isCompleted: false),
                        SubTask(name: "Creating generators with `yield`", isCompleted: false)
                    ]),
                    Task(name: "Comprehensions & Lambda", isCompleted: false, subTasks: [
                        SubTask(name: "List, dict, and set comprehensions", isCompleted: false),
                        SubTask(name: "Lambda functions and `map`, `filter`, `reduce`", isCompleted: false)
                    ]),
                    Task(name: "Concurrency in Python", isCompleted: false, subTasks: [
                        SubTask(name: "Threading vs Multiprocessing", isCompleted: false),
                        SubTask(name: "AsyncIO Basics", isCompleted: false)
                    ])
                ]),

                // Phase 7: Real-World Python Projects
                Phase(name: "Phase 7: Build & Deploy Projects", tasks: [
                    Task(name: "Build Small Projects", isCompleted: false, subTasks: [
                        SubTask(name: "To-Do CLI or GUI App", isCompleted: false),
                        SubTask(name: "Weather Checker with API", isCompleted: false),
                        SubTask(name: "Expense Tracker CSV + Pandas", isCompleted: false)
                    ]),
                    Task(name: "Deploy Your Code", isCompleted: false, subTasks: [
                        SubTask(name: "Use Git & GitHub", isCompleted: false),
                        SubTask(name: "Package a Python script as an executable", isCompleted: false),
                        SubTask(name: "Deploy a simple Streamlit or Flask app", isCompleted: false)
                    ])
                ])
            ]
        )
    }

    static func createDataScienceRoadmap(
        withTitle title: String = "Data Science Roadmap",
        description: String = "A deep dive into data science—from data wrangling and statistics to impactful visualizations and projects.",
        imageName: String = "chart.bar.doc.horizontal"
    ) -> Roadmap {
        return Roadmap(
            id: UUID(),
            title: title,
            description: description,
            imageName: imageName,
            phases: [

                // Phase 1: Data Fundamentals
                Phase(name: "Phase 1: Data Fundamentals", tasks: [
                    Task(name: "Understand What Data Science Is", isCompleted: false, subTasks: [
                        SubTask(name: "History & Evolution of Data Science", isCompleted: false),
                        SubTask(name: "Roles: Analyst vs Scientist vs Engineer", isCompleted: false),
                        SubTask(name: "Real-world Impact of Data Science", isCompleted: false)
                    ]),
                    Task(name: "Learn Data Types & Structures", isCompleted: false, subTasks: [
                        SubTask(name: "Structured vs Unstructured Data", isCompleted: false),
                        SubTask(name: "Categorical vs Numerical vs Time Series", isCompleted: false),
                        SubTask(name: "Learn about Tabular Formats (CSV, Excel, SQL)", isCompleted: false)
                    ])
                ]),

                // Phase 2: Data Collection & Wrangling
                Phase(name: "Phase 2: Data Collection & Wrangling", tasks: [
                    Task(name: "Data Collection Techniques", isCompleted: false, subTasks: [
                        SubTask(name: "APIs & Web Scraping Basics", isCompleted: false),
                        SubTask(name: "Importing Data from CSV/Excel/SQL", isCompleted: false),
                        SubTask(name: "Handling Real-world Datasets (e.g., Kaggle)", isCompleted: false)
                    ]),
                    Task(name: "Data Cleaning Essentials", isCompleted: false, subTasks: [
                        SubTask(name: "Detect & Handle Missing Values", isCompleted: false),
                        SubTask(name: "Outlier Detection & Treatment", isCompleted: false),
                        SubTask(name: "Fixing Data Types and Parsing Dates", isCompleted: false)
                    ]),
                    Task(name: "Data Transformation", isCompleted: false, subTasks: [
                        SubTask(name: "Normalization vs Standardization", isCompleted: false),
                        SubTask(name: "Encoding Categorical Variables", isCompleted: false),
                        SubTask(name: "Feature Engineering Basics", isCompleted: false)
                    ])
                ]),

                // Phase 3: Exploratory Data Analysis (EDA)
                Phase(name: "Phase 3: Exploratory Data Analysis (EDA)", tasks: [
                    Task(name: "Understand the Purpose of EDA", isCompleted: false, subTasks: [
                        SubTask(name: "Initial Observations & Data Profiling", isCompleted: false),
                        SubTask(name: "Univariate vs Bivariate Analysis", isCompleted: false)
                    ]),
                    Task(name: "Use Visualizations for EDA", isCompleted: false, subTasks: [
                        SubTask(name: "Histograms, Boxplots, Scatterplots", isCompleted: false),
                        SubTask(name: "Correlation Heatmaps", isCompleted: false),
                        SubTask(name: "Pair Plots with Seaborn", isCompleted: false)
                    ]),
                    Task(name: "Summarize Key Findings", isCompleted: false, subTasks: [
                        SubTask(name: "Descriptive Stats (Mean, Median, Mode)", isCompleted: false),
                        SubTask(name: "Insights Extraction", isCompleted: false),
                        SubTask(name: "Communicate Findings Effectively", isCompleted: false)
                    ])
                ]),

                // Phase 4: Data Visualization Mastery
                Phase(name: "Phase 4: Data Visualization Mastery", tasks: [
                    Task(name: "Learn Visualization Best Practices", isCompleted: false, subTasks: [
                        SubTask(name: "Chart Selection for Data Types", isCompleted: false),
                        SubTask(name: "Avoiding Misleading Graphs", isCompleted: false)
                    ]),
                    Task(name: "Master Plotting Libraries", isCompleted: false, subTasks: [
                        SubTask(name: "Matplotlib Basics & Advanced Customization", isCompleted: false),
                        SubTask(name: "Seaborn for Statistical Charts", isCompleted: false),
                        SubTask(name: "Plotly for Interactive Dashboards", isCompleted: false)
                    ]),
                    Task(name: "Create Insightful Dashboards", isCompleted: false, subTasks: [
                        SubTask(name: "Build Dashboards with Streamlit", isCompleted: false),
                        SubTask(name: "Embed Visuals into Reports", isCompleted: false)
                    ])
                ]),

                // Phase 5: Applied Statistics for Data Science
                Phase(name: "Phase 5: Applied Statistics", tasks: [
                    Task(name: "Learn Descriptive Statistics", isCompleted: false, subTasks: [
                        SubTask(name: "Mean, Median, Mode, Range, Variance, Std Dev", isCompleted: false),
                        SubTask(name: "Skewness & Kurtosis", isCompleted: false)
                    ]),
                    Task(name: "Inferential Statistics", isCompleted: false, subTasks: [
                        SubTask(name: "Hypothesis Testing: t-test, chi-square", isCompleted: false),
                        SubTask(name: "P-values, Confidence Intervals", isCompleted: false),
                        SubTask(name: "Correlation vs Causation", isCompleted: false)
                    ]),
                    Task(name: "Probability Concepts", isCompleted: false, subTasks: [
                        SubTask(name: "Discrete vs Continuous Probability", isCompleted: false),
                        SubTask(name: "Bayes' Theorem", isCompleted: false),
                        SubTask(name: "Distribution Types: Normal, Binomial, Poisson", isCompleted: false)
                    ])
                ]),

                // Phase 6: SQL for Data Analysis
                Phase(name: "Phase 6: SQL for Data Analysis", tasks: [
                    Task(name: "Master Basic SQL", isCompleted: false, subTasks: [
                        SubTask(name: "SELECT, WHERE, ORDER BY, LIMIT", isCompleted: false),
                        SubTask(name: "GROUP BY and Aggregation", isCompleted: false),
                        SubTask(name: "Joins: INNER, LEFT, RIGHT, FULL", isCompleted: false)
                    ]),
                    Task(name: "Intermediate & Analytical SQL", isCompleted: false, subTasks: [
                        SubTask(name: "Window Functions (ROW_NUMBER, RANK)", isCompleted: false),
                        SubTask(name: "Subqueries and CTEs", isCompleted: false),
                        SubTask(name: "Handling NULLs and CASE Statements", isCompleted: false)
                    ])
                ]),

                // Phase 7: End-to-End Data Science Projects
                Phase(name: "Phase 7: End-to-End Projects", tasks: [
                    Task(name: "Clean & Analyze a Real Dataset", isCompleted: false, subTasks: [
                        SubTask(name: "Choose a Kaggle or UCI Dataset", isCompleted: false),
                        SubTask(name: "Apply Cleaning, EDA, Visualization", isCompleted: false)
                    ]),
                    Task(name: "Tell a Story with Data", isCompleted: false, subTasks: [
                        SubTask(name: "Develop a Clear Problem Statement", isCompleted: false),
                        SubTask(name: "Use Data to Support Recommendations", isCompleted: false)
                    ]),
                    Task(name: "Document & Share Work", isCompleted: false, subTasks: [
                        SubTask(name: "Create a Jupyter Notebook Report", isCompleted: false),
                        SubTask(name: "Publish on GitHub with README", isCompleted: false),
                        SubTask(name: "Optional: Present Findings in a Blog or Portfolio", isCompleted: false)
                    ])
                ])
            ]
        )
    }

    // Create ML Roadmap template
    static func createMLRoadmap(withTitle title: String = "Machine Learning Roadmap",
                                description: String = "A comprehensive guide to mastering machine learning from Python basics to MLOps.",
                                imageName: String = "brain.head.profile") -> Roadmap {
        return Roadmap(
            id: UUID(),
            title: title,
            description: description,
            imageName: imageName,
            phases: [
                // Phase 1: Python Mastery
                Phase(name: "Phase 1: Python Mastery", tasks: [
                    Task(name: "Learn Python Basics", isCompleted: false, subTasks: [
                        SubTask(name: "Install Python", isCompleted: false),
                        SubTask(name: "Understand Variables & Data Types", isCompleted: false),
                        SubTask(name: "Learn Basic Syntax", isCompleted: false),
                        SubTask(name: "Practice with Python Exercises", isCompleted: false)
                    ]),
                    Task(name: "Understand OOP in Python", isCompleted: false, subTasks: [
                        SubTask(name: "Learn Classes & Objects", isCompleted: false),
                        SubTask(name: "Understand Inheritance", isCompleted: false),
                        SubTask(name: "Practice with Python OOP Exercises", isCompleted: false)
                    ]),
                    Task(name: "Master Pandas and NumPy", isCompleted: false, subTasks: [
                        SubTask(name: "Learn Pandas DataFrame Basics", isCompleted: false),
                        SubTask(name: "Understand NumPy Arrays", isCompleted: false),
                        SubTask(name: "Practice Data Manipulation", isCompleted: false)
                    ]),
                    Task(name: "Visualize Data with Matplotlib", isCompleted: false, subTasks: [
                        SubTask(name: "Learn Basic Plotting", isCompleted: false),
                        SubTask(name: "Create Various Graphs", isCompleted: false),
                        SubTask(name: "Master Plot Customization", isCompleted: false)
                    ])
                ]),
                
                // Phase 2: Machine Learning
                Phase(name: "Phase 2: Machine Learning", tasks: [
                    Task(name: "Learn Sklearn Basics", isCompleted: false, subTasks: [
                        SubTask(name: "Understand Machine Learning Terminology", isCompleted: false),
                        SubTask(name: "Learn Sklearn APIs", isCompleted: false),
                        SubTask(name: "Apply Sklearn to Simple Datasets", isCompleted: false)
                    ]),
                    Task(name: "Understand Exploratory Data Analysis (EDA)", isCompleted: false, subTasks: [
                        SubTask(name: "Learn EDA Techniques", isCompleted: false),
                        SubTask(name: "Visualize Data Distributions", isCompleted: false),
                        SubTask(name: "Handle Missing Data", isCompleted: false)
                    ]),
                    Task(name: "Build ML Models", isCompleted: false, subTasks: [
                        SubTask(name: "Understand Classification vs Regression", isCompleted: false),
                        SubTask(name: "Train Models with Sklearn", isCompleted: false),
                        SubTask(name: "Evaluate Model Performance", isCompleted: false)
                    ])
                ]),
                
                // Phase 3: Deep Learning
                Phase(name: "Phase 3: Deep Learning", tasks: [
                    Task(name: "Learn Neural Networks", isCompleted: false, subTasks: [
                        SubTask(name: "Understand Neural Network Basics", isCompleted: false),
                        SubTask(name: "Learn Backpropagation", isCompleted: false),
                        SubTask(name: "Implement Basic Neural Networks", isCompleted: false)
                    ]),
                    Task(name: "Understand CNNs and RNNs", isCompleted: false, subTasks: [
                        SubTask(name: "Learn CNN Architecture", isCompleted: false),
                        SubTask(name: "Implement a Convolutional Neural Network", isCompleted: false),
                        SubTask(name: "Learn RNNs and LSTMs", isCompleted: false)
                    ]),
                    Task(name: "Experiment with Transformers", isCompleted: false, subTasks: [
                        SubTask(name: "Learn Transformer Architecture", isCompleted: false),
                        SubTask(name: "Train a Transformer Model", isCompleted: false)
                    ])
                ]),
                
                // Phase 4: NLP & LLMs
                Phase(name: "Phase 4: NLP & LLMs", tasks: [
                    Task(name: "Text Preprocessing (TF-IDF, BOW, Word2Vec)", isCompleted: false, subTasks: [
                        SubTask(name: "Learn Text Tokenization", isCompleted: false),
                        SubTask(name: "Understand TF-IDF and Bag of Words", isCompleted: false),
                        SubTask(name: "Understand Word2Vec", isCompleted: false)
                    ]),
                    Task(name: "Sequence Models (RNN, LSTM)", isCompleted: false, subTasks: [
                        SubTask(name: "Learn RNN Basics", isCompleted: false),
                        SubTask(name: "Implement an LSTM", isCompleted: false)
                    ]),
                    Task(name: "Transformers: BERT, GPT", isCompleted: false, subTasks: [
                        SubTask(name: "Understand BERT and GPT Models", isCompleted: false),
                        SubTask(name: "Implement BERT/GPT for NLP", isCompleted: false)
                    ]),
                    Task(name: "Implement Hugging Face Transformers", isCompleted: false, subTasks: [
                        SubTask(name: "Set up Hugging Face", isCompleted: false),
                        SubTask(name: "Fine-tune Pre-trained Transformers", isCompleted: false)
                    ]),
                    Task(name: "LangChain Integration with LLMs", isCompleted: false, subTasks: [
                        SubTask(name: "Learn LangChain Basics", isCompleted: false),
                        SubTask(name: "Integrate LangChain with LLMs", isCompleted: false)
                    ]),
                    Task(name: "Create a Chatbot with LangChain", isCompleted: false, subTasks: [
                        SubTask(name: "Set up Chatbot Framework", isCompleted: false),
                        SubTask(name: "Integrate LLM into Chatbot", isCompleted: false)
                    ]),
                    Task(name: "Prompt Engineering", isCompleted: false, subTasks: [
                        SubTask(name: "Understand Prompt Engineering", isCompleted: false),
                        SubTask(name: "Design Prompts for Different Tasks", isCompleted: false)
                    ])
                ]),
                
                // Phase 5: MLOps
                Phase(name: "Phase 5: MLOps", tasks: [
                    Task(name: "ML Project Structuring (cookiecutter)", isCompleted: false, subTasks: [
                        SubTask(name: "Learn Project Structure Basics", isCompleted: false),
                        SubTask(name: "Understand Cookiecutter Templates", isCompleted: false)
                    ]),
                    Task(name: "Model Versioning (MLFlow, DVC)", isCompleted: false, subTasks: [
                        SubTask(name: "Learn MLFlow for Model Versioning", isCompleted: false),
                        SubTask(name: "Integrate DVC into ML Workflow", isCompleted: false)
                    ]),
                    Task(name: "Model Deployment (FastAPI, Docker)", isCompleted: false, subTasks: [
                        SubTask(name: "Learn FastAPI Basics", isCompleted: false),
                        SubTask(name: "Dockerize ML Models", isCompleted: false),
                        SubTask(name: "Deploy Models using FastAPI", isCompleted: false)
                    ]),
                    Task(name: "CI/CD for ML with GitHub Actions", isCompleted: false, subTasks: [
                        SubTask(name: "Understand CI/CD Concepts", isCompleted: false),
                        SubTask(name: "Set up GitHub Actions for ML", isCompleted: false)
                    ]),
                    Task(name: "Model Monitoring & Feedback Loops", isCompleted: false, subTasks: [
                        SubTask(name: "Learn Monitoring Best Practices", isCompleted: false),
                        SubTask(name: "Integrate Feedback Loops", isCompleted: false)
                    ])
                ]),
                
                // Phase 6: Math for ML
                Phase(name: "Phase 6: Math for ML", tasks: [
                    Task(name: "Linear Algebra (Vectors, Matrices)", isCompleted: false, subTasks: [
                        SubTask(name: "Learn Vectors and Matrices", isCompleted: false),
                        SubTask(name: "Understand Matrix Operations", isCompleted: false)
                    ]),
                    Task(name: "Probability & Statistics", isCompleted: false, subTasks: [
                        SubTask(name: "Understand Probability Distributions", isCompleted: false),
                        SubTask(name: "Learn Statistical Inference", isCompleted: false)
                    ]),
                    Task(name: "Calculus (Derivatives, Gradients)", isCompleted: false, subTasks: [
                        SubTask(name: "Learn Derivatives", isCompleted: false),
                        SubTask(name: "Understand Gradient Descent", isCompleted: false)
                    ]),
                    Task(name: "Optimization Techniques (Gradient Descent)", isCompleted: false, subTasks: [
                        SubTask(name: "Learn Gradient Descent", isCompleted: false),
                        SubTask(name: "Implement Gradient Descent from Scratch", isCompleted: false)
                    ])
                ])
            ]
        )
    }

    
    // Create empty roadmap template
    static func createEmptyRoadmap(withTitle title: String = "New Roadmap",
                                   description: String = "Your custom learning roadmap",
                                   imageName: String = "star.fill") -> Roadmap {
        return Roadmap(
            id: UUID(),
            title: title,
            description: description,
            imageName: imageName,
            phases: []
        )
    }
}
