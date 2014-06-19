function [responses, totalReward, rewardVsTime] = runTest(rightAnswers, socIn, socInWeight, momentum, rewardAmount, epsilon, discount)
%runTest return a vector of binary responses to the test questions and the
%reward gathered.

%rightAnswers - Row vector of correct answers. Should be a binary vector.
%socIn - Row vector of social input for each question. Should be a binary
%vector.
%socInWeight - The amount social input is considered. Should be a number
%from 0 to 0.9.
%momentum - The rate at which the rate of change of the left and right
%quality changes. This allows the neural network to handle volitility.
%rewardAmount - The reward received per correct answer.
%epsilon - The learning rate.

    numQuestions = size(rightAnswers, 2);
    rewardVsTime = zeros(2, numQuestions); %for plotting
    totalReward = 0;
    
    QL = 0.5; %quality of left decision
    qLInc = 0;
    
    QR = 0.5; %quality of right decision
	qRInc = 0; %amount 
    
    for i = 1:numQuestions
        SI = socIn(i);
        RA = rightAnswers(i);
        
        %changes the SI to either -1 or 1. Treated as the output of a
        %linear neuron with weight of 2 connecting it to SI and a bias of
        %-1.
        
        linNeuOut = -1 + 2*SI;
        
        %Takes quality of a left decision and gives it a weight of 1,
        %and takes the quality of a right decision and gives it a weight of
        %-1, then feeds them both as input to a neuron with a tan activation
        %function, bounding it between -1 and 1.
        
        tanhNeuOut = tanh(QL - QR);
        
        %combines the modified social input and the output of the tan
        %neuron into one value, then feeds it as input into a binary
        %threshold neuron.
        
        binNeuIn = linNeuOut*socInWeight + tanhNeuOut;
        binNeuOut = (binNeuIn > 0)*1;
        
        responses(i) = binNeuOut;
        
        %Set the current reward to 0 if none was earned or the amount per
        %correct answer if the right answer was given, then add it to the
        %total reward.
        
        currentReward = (RA == binNeuOut)*rewardAmount;
        totalReward = totalReward + currentReward;
        
        %reward time plot variable recording.
        
        rewardVsTime(1, i) = i;
        rewardVsTime(2, i) = totalReward;
        
        %Update the QBlock which won out, if it failed to be correct the
        %reward input will be 0, if it was right it will be the set reward
        %per answer
        
        if tanhNeuOut > 0
            [QL, qLInc] = updateQBlock(epsilon, momentum, discount, QL, qLInc, currentReward);
        elseif tanhNeuOut <= 0
            [QR, qRInc] = updateQBlock(epsilon, momentum, discount, QR, qRInc, currentReward);
        end
    end
end

%NEURAL NETWORK DIAGRAM

%                                |                       OUTPUT
%                              (bin)
%                               /\
%                 w=socInWeight/  \w=1
%                             /    \
%                            /      \
%                        (linNeu)  (tanhNeu)
%                          /|          /\
%                         / |      w=1/  \w=-1
%                        /  |w=2     /    \
%                       -1  |      (QL)  (QR)
%                           |        
%                           |         
%                           |          
%                          SI                            INPUT      
