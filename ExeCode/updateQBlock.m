function [newQ, newQInc] = updateQBlock(epsilon, momentum, discount, oldQ, oldQInc, reward)
%runQBlock returns the new quality of a decision based on the reward it
%provided, also returns the amount Q changed by

%momentum - The rate at which the rate of change of the left and right
%quality changes. This allows the neural network to handle volitility.
%reward - The reward received for the answer given.
%epsilon - The learning rate.
%discount - Given by the q learning algorithm update formula.
%oldQ - The value of Q from the previous iteration.
%oldQInc - The amount Q changed in the previous iteration.

    %The basic forumla for iterating the qauality in q learning, just
    %modified to give us the amount the quality will change by instead of
    %just giving us the new Q, also modified to incorporate momentum to
    %account for volitlity in the correct answers.
    
    newQInc = momentum*oldQInc + epsilon*(reward + discount*oldQ - oldQ);
    newQ = newQInc + oldQ;
    
    
end