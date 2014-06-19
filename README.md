socialLearningSimulator
=======================

MATLAB code for a cool neural network embedded in a Q Learning algorithm

This was used in my Final Year Project in the university. Please use it however you want. I have input a lot of hours into this. 

If you'd like to alter something to improve it go for it. 

If you have any questions you can contact me if you want and I will try to reply as soon as possible.

=====================================================================

Please check out Appendix E for User Manual on how to install.

=====================================================================


-Right Answers (rightAnswers) - Row vector of correct answers. Should be a binary vector. Contained in a file called “RightAnswers.dat”.
• Social Input (socIn) - Row vector of social input for each question. Should be a binary vector.
• Social Input Weight (socInWeight) - The amount social input is considered. Should be a number from 0 to 0.9.
• Momentum (momentum - The rate of change of the left and right quality changes. This allows the neural network to handle volatility.
• Reward Amount (rewardAmount) - Reward received per correct answer.
• Discount (gamma) - The discount factor determines the importance of future rewards. • Initial Learning Rate (alpha or epsilon) - The initial learning rate.
- The value of Q from the previous iteration.
• oldQInc - The amount Q changed in the previous iteration.

=====================================================================

• RightAnswers.dat - contains the dataset for answers
• RunAgentGui.fig - graphics for GUI
• RunAgentGui.m - launcher file, which launches GUI
• runTest.m - this is where all the data gets run through the neural network
• updateQBlock.m - Q Learning bit of the algorithm (gets called from runTest.m)