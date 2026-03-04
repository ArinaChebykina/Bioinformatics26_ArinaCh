data <- read.csv("r_task/sample_data.csv")

mean_score <- mean(data$Score)
cat ("Score (ср.знач.):", mean_score, "\n")

treatment_data <- subset(data, Group == "Treatment")
max_tr <- max(treatment_data$Score)
cat ("Max Score in Treatment:", max_tr, "\n")

png("r_task/score_boxplot.png", width=2000, height=1500, res = 300)
boxplot(Score ~ Group, data = data, xlab = "Group", ylab = "Score", main = "Score Distribution by Group", col = c("red", "blue"))
dev.off()
